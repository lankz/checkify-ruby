require "json"
require "checkify"
require "webmock/rspec"
require "vcr"
require "dotenv/load" if ENV["CHECKIFY_RECORD"] == "1"

WebMock.disable_net_connect!

# mimics API JSON: Date → ISO string and string keys so build_from_hash can parse again after to_hash
module CheckifyModelSpecSupport
  def round_trip_api_model(klass, api_hash)
    obj = klass.build_from_hash(api_hash)
    wire = JSON.parse(JSON.generate(json_wire(obj.to_hash)))
    klass.build_from_hash(wire)
  end

  private

    def json_wire(value)
      case value
      when Hash
        value.each_with_object({}) { |(k, v), h| h[k.to_s] = json_wire(v) }
      when Array
        value.map { |v| json_wire(v) }
      when Date
        value.iso8601
      else
        value
      end
    end
end

RECORDING = ENV["CHECKIFY_RECORD"] == "1"
if RECORDING && ENV.fetch("CHECKIFY_API_KEY", "").strip.empty?
  abort "CHECKIFY_RECORD=1 requires CHECKIFY_API_KEY in your environment or .env"
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = {
    record: RECORDING ? :new_episodes : :none,
    match_requests_on: [:method, :uri, :body]
  }
  config.filter_sensitive_data("<CHECKIFY_API_KEY>") { ENV.fetch("CHECKIFY_API_KEY", "test-key") }
  # Keep production requests below the free plan's 30 requests/minute limit.
  config.before_http_request do |request|
    sleep 2.1 if RECORDING && request.real?
  end
  config.before_record do |interaction|
    %w[Authorization Cookie].each { |header| interaction.request.headers.delete(header) }
    %w[Set-Cookie].each { |header| interaction.response.headers.delete(header) }
    # Account data is private. Redact at recording time, preserving the JSON types.
    if URI(interaction.request.uri).path == "/api/v1/account" && interaction.response.status.code == 200
      body = JSON.parse(interaction.response.body)
      %w[units_used units_limit units_remaining].each { |key| body[key] = 0 if body.key?(key) }
      %w[period_start period_end cancels_at].each { |key| body[key] = "1970-01-01" if body[key] }
      body["usage"] = {} if body.key?("usage")
      interaction.response.body = JSON.generate(body)
    end
  end
end

RSpec.configure do |config|
  config.include CheckifyModelSpecSupport
  config.before do
    Checkify.configure do |c|
      c.access_token = RECORDING ? ENV.fetch("CHECKIFY_API_KEY") : "test-key"
      c.timeout = 30
    end
  end
  config.expect_with(:rspec) { |expectations| expectations.include_chain_clauses_in_custom_matcher_descriptions = true }
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.order = :random
  Kernel.srand config.seed
end
