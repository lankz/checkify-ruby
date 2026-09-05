require "spec_helper"
require "socket"

# Simulated responses: real bulk processing requires a paid Checkify plan.
# These are deliberately separate from the recorded production cassettes.
describe Checkify::BatchApi do
  let(:api) { described_class.new }
  let(:base_url) { "https://checkify.com.au/api/v1/bulk" }
  let(:job) { { id: 123, endpoint: "abn", status: "pending", total_rows: 1, created_at: "2026-04-01T00:00:00Z" } }

  it "submits a JSON job and deserializes the created job" do
    request = stub_request(:post, base_url)
      .with(headers: { "Content-Type" => "application/json", "Authorization" => /\ABearer / },
            body: JSON.generate(endpoint: "abn", items: ["26008672179"]))
      .to_return(status: 201, headers: { "Content-Type" => "application/json" }, body: JSON.generate(job))
    result = api.create_bulk_job(Checkify::BulkCreateRequest.new(endpoint: "abn", items: ["26008672179"]))
    expect(request).to have_been_requested.once
    expect(result).to be_a(Checkify::BulkJob)
    expect(result.id).to eq(123)
    expect(result.created_at).to be_a(Time)
  end

  it "submits object rows without losing their fields" do
    rows = [{ lat: -33.8688, lng: 151.2093 }]
    request = stub_request(:post, base_url)
      .with(body: JSON.generate(endpoint: "reverse", items: rows))
      .to_return(status: 201, headers: { "Content-Type" => "application/json" }, body: JSON.generate(job.merge(endpoint: "reverse")))
    result = api.create_bulk_job(Checkify::BulkCreateRequest.new(endpoint: "reverse", items: rows))
    expect(request).to have_been_requested.once
    expect(result.endpoint).to eq("reverse")
  end

  it "sends the CSV file and endpoint as multipart form data" do
    # Exercise libcurl's actual multipart encoding against a tiny simulated bulk server.
    server = TCPServer.new("127.0.0.1", 0)
    worker = Thread.new do
      socket = server.accept
      headers = +""
      while (line = socket.gets) && line != "\r\n"
        headers << line
      end
      socket.write("HTTP/1.1 100 Continue\r\n\r\n") if headers.match?(/Expect: 100-continue/i)
      length = headers[/Content-Length: (\d+)/i, 1].to_i
      body = socket.read(length)
      response = JSON.generate(job)
      socket.write("HTTP/1.1 201 Created\r\nContent-Type: application/json\r\nContent-Length: #{response.bytesize}\r\nConnection: close\r\n\r\n#{response}")
      [headers, body]
    ensure
      socket&.close
    end
    config = Checkify::Configuration.new
    config.scheme = "http"
    config.host = "127.0.0.1:#{server.addr[1]}"
    config.server_index = nil
    config.timeout = 5
    local_api = described_class.new(Checkify::ApiClient.new(config))
    WebMock.disable_net_connect!(allow_localhost: true)
    VCR.turned_off do
      Tempfile.create(["bulk", ".csv"]) do |file|
        file.write("abn\n26008672179\n")
        file.rewind
        result = local_api.create_bulk_job({}, header_params: { "Content-Type" => "multipart/form-data" },
                                               form_params: { "endpoint" => "abn", "file" => file })
        expect(result.id).to eq(123)
      end
    end
    headers, body = worker.value
    expect(headers).to match(/Content-Type: multipart\/form-data; boundary=/i)
    expect(body).to include('name="endpoint"', 'name="file"', "abn\n26008672179\n")
  ensure
    WebMock.disable_net_connect!
    worker&.kill
    worker&.join
    server&.close
  end

  it "fetches job status using the job ID" do
    request = stub_request(:get, "#{base_url}/123")
      .to_return(headers: { "Content-Type" => "application/json" }, body: JSON.generate(job.merge(status: "completed")))
    expect(api.get_bulk_job(123).status).to eq("completed")
    expect(request).to have_been_requested.once
  end

  it "downloads CSV into a temporary file" do
    csv = "abn,entityName\n26008672179,BUNNINGS GROUP LIMITED\n"
    request = stub_request(:get, "#{base_url}/123/download")
      .to_return(body: csv, headers: { "Content-Type" => "text/csv", "Content-Disposition" => 'attachment; filename="../../results.csv"' })
    file = api.download_bulk_results(123)
    expect(request).to have_been_requested.once
    expect(file).to be_a(Tempfile)
    expect(File.read(file.path)).to eq(csv)
    expect(File.basename(file.path)).to start_with("results.csv-")
  ensure
    file&.unlink
  end

  [401, 403, 404, 422, 429, 500].each do |status|
    it "preserves HTTP #{status} error details" do
      stub_request(:get, "#{base_url}/123")
        .to_return(status: status, body: '{"error":"Request failed"}', headers: { "Content-Type" => "application/json", "Retry-After" => "60" })
      expect { api.get_bulk_job(123) }.to raise_error(Checkify::ApiError) do |error|
        expect(error.code).to eq(status)
        expect(error.response_body).to include("Request failed")
        expect(error.response_headers["Retry-After"]).to eq("60")
      end
    end
  end

  it "reports a transport timeout" do
    stub_request(:get, "#{base_url}/123").to_timeout
    expect { api.get_bulk_job(123) }.to raise_error(Checkify::ApiError, /timed out/)
  end

  it "rejects missing arguments before making an HTTP request" do
    expect { api.create_bulk_job(nil) }.to raise_error(ArgumentError)
    expect { api.get_bulk_job(nil) }.to raise_error(ArgumentError)
    expect { api.download_bulk_results(nil) }.to raise_error(ArgumentError)
  end
end
