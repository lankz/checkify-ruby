require "spec_helper"

describe Checkify::Client do
  it "looks up a business through the client", vcr: { cassette_name: "business/abn_lookup" } do
    client = described_class.new(api_key: Checkify.configure.access_token)
    result = client.business.abn_lookup("26 008 672 179")
    expect(result).to be_a(Checkify::AbnResponse)
    expect(result.entity_name).to eq("BUNNINGS GROUP LIMITED")
  end

  it "shares configuration across endpoint groups without changing other clients or global defaults" do
    first = described_class.new(api_key: "first-key", timeout: 5)
    second = described_class.new(api_key: "second-key")
    global_token = Checkify.configure.access_token

    [first.account, first.address, first.batch, first.business, first.communication, first.identity].each do |endpoint|
      request = endpoint.api_client.build_request(:get, "/account", auth_names: ["BearerAuth"])
      expect(request.options[:headers]["Authorization"]).to eq("Bearer first-key")
      expect(request.options[:timeout]).to eq(5)
      expect(endpoint.api_client).to equal(first.account.api_client)
    end

    first.business.api_client.config.access_token = "changed-key"
    expect(second.business.api_client.config.access_token).to eq("second-key")
    expect(second.business.api_client.config.timeout).to eq(30)
    expect(Checkify.configure.access_token).to eq(global_token)
    expect(Checkify.configure.timeout).to eq(30)
  end

  it "accepts advanced configuration scoped to the client" do
    client = described_class.new(api_key: "test-key") do |config|
      config.host = "example.com"
    end
    expect(client.account.api_client.build_request(:get, "/account").url).to eq("https://example.com/api/v1/account")
    expect(Checkify.configure.host).to eq("checkify.com.au")
  end

  it "rejects missing, blank, and non-string API keys" do
    expect { described_class.new }.to raise_error(ArgumentError)
    [nil, "", " \t", 123].each do |key|
      expect { described_class.new(api_key: key) }.to raise_error(ArgumentError, "api_key must be a nonblank String")
    end
  end
end
