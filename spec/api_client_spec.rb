require "spec_helper"

describe Checkify::ApiClient do
  let(:config) { Checkify::Configuration.new }
  let(:client) { described_class.new(config) }

  it "sends bearer authentication in the header, not in the URL" do
    config.access_token = "test-key"
    request = client.build_request(:get, "/abn", auth_names: ["BearerAuth"], query_params: { abn: "26 008 672 179" })
    expect(request.options[:headers]["Authorization"]).to eq("Bearer test-key")
    expect(request.options[:params]).to eq(abn: "26 008 672 179")
    expect(request.url).not_to include("test-key")
  end

  it "uses a refreshed token on each request" do
    token = "first"
    config.access_token_getter = -> { token }
    expect(client.build_request(:get, "/account", auth_names: ["BearerAuth"]).options[:headers]["Authorization"]).to eq("Bearer first")
    token = "second"
    expect(client.build_request(:get, "/account", auth_names: ["BearerAuth"]).options[:headers]["Authorization"]).to eq("Bearer second")
  end

  it "configures a timeout and verifies TLS certificates and hostnames" do
    config.timeout = 5
    options = client.build_request(:get, "/account").options
    expect(options).to include(timeout: 5, ssl_verifypeer: true, ssl_verifyhost: 2)
  end

  it "uses a finite timeout by default and allows explicitly disabling it" do
    expect(client.build_request(:get, "/account").options[:timeout]).to eq(30)
    config.timeout = 0
    expect(client.build_request(:get, "/account").options[:timeout]).to eq(0)
  end

  it "follows redirects by default and respects an explicit false" do
    expect(client.build_request(:get, "/account").options[:followlocation]).to be(true)
    expect(client.build_request(:get, "/account", follow_location: false).options[:followlocation]).to be(false)
  end

  it "identifies the gem and version in its user agent" do
    expect(client.build_request(:get, "/account").options[:headers]["User-Agent"]).to eq("checkify/#{Checkify::VERSION}/ruby")
  end

  it "rejects invalid JSON instead of silently returning an empty response" do
    response = Typhoeus::Response.new(body: "not json", headers: { "Content-Type" => "application/json" })
    expect { client.deserialize(response, "Account") }.to raise_error(JSON::ParserError)
  end

  it "preserves response details on API errors", vcr: { cassette_name: "errors/invalid_abn" } do
    expect { Checkify::BusinessApi.new.abn_lookup("0") }.to raise_error(Checkify::ApiError) do |error|
      expect(error.code).to eq(422)
      body = JSON.parse(error.response_body)
      expect(body["message"]).to be_a(String)
      expect(body.fetch("errors").fetch("abn")).to all(be_a(String))
      expect(Checkify::Error.build_from_hash(body).errors["abn"]).not_to be_empty
      expect(error.response_headers).not_to be_empty
      expect(error.message).to include("422")
    end
  end

  it "reports an invalid API key", vcr: { cassette_name: "errors/unauthorized" } do
    config.access_token = "invalid-test-key"
    expect { Checkify::AccountApi.new(client).get_account }.to raise_error(Checkify::ApiError) do |error|
      expect(error.code).to eq(401)
    end
  end

  it "reports an unknown address", vcr: { cassette_name: "errors/not_found" } do
    expect { Checkify::AddressApi.new.autocomplete_details("CK-DOES-NOT-EXIST") }.to raise_error(Checkify::ApiError) do |error|
      expect(error.code).to eq(404)
    end
  end
end
