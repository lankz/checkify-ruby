# Checkify for Ruby

Unofficial Ruby client for the [Checkify API](https://checkify.com.au/developers) — Australian and New Zealand address validation, business lookups, identity checks, and communication validation.

## Installation

Requires Ruby 3.3 or later and libcurl (normally included with macOS and Linux).

Add to your Gemfile:

```ruby
gem "checkify", "~> 0.1.0"
```

Then run `bundle install`.

## Configuration

```ruby
require "checkify"

client = Checkify::Client.new(api_key: ENV.fetch("CHECKIFY_API_KEY"))
```

Each client has its own credentials and configuration. Requests time out after 30
seconds by default; pass `timeout: 60` to change this (or `timeout: 0` to disable it).
For advanced configuration, pass a block:

```ruby
client = Checkify::Client.new(api_key: ENV.fetch("CHECKIFY_API_KEY"), timeout: 60) do |config|
  config.debugging = false
end
```

Two token types are available — see the [Checkify docs](https://checkify.com.au/developers) for details:

- **Public** (`ck_pub_...`) — safe for browser/mobile use, domain-restricted
- **Private** (`ck_prv_...`) — server-side only, higher rate limits

## Usage

### Address autocomplete

```ruby
address_api = client.address

# type-ahead search (free, 0 units)
results = address_api.autocomplete("1 macquarie st sydney")
# => a hash of address IDs to highlighted labels

# full structured record (1 unit)
details = address_api.autocomplete_details(results.keys.first)
# => #<Checkify::AddressDetails street="1 MACQUARIE ST", city="SYDNEY", postcode="2000", ...>
```

### Suburb and postcode lookup

```ruby
# suburb autocomplete (free)
suburbs = address_api.autocomplete_suburb("sydney")

# full suburb details (1 unit)
address_api.autocomplete_suburb_details(suburbs.keys.first)

# all suburbs for a postcode (1 unit)
address_api.postcode_lookup("2000")
```

### Reverse geocode

```ruby
address_api.reverse_geocode(-33.8688, 151.2130, radius: 200, limit: 3)
```

### ABN / ACN lookup

```ruby
business_api = client.business

abn = business_api.abn_lookup("26 008 672 179")
abn.entity_name    # => "BUNNINGS GROUP LIMITED"
abn.abn_details.active  # => true

acn = business_api.acn_lookup("008 672 179")
acn.addresses      # => [#<Checkify::AcnAddress ...>, ...]
acn.documents      # => [#<Checkify::AsicDocument ...>, ...]
```

### Business activity search

```ruby
business_api.business_activity("accounting", limit: 5)
```

### Company / business name availability

```ruby
business_api.company_name_check("Acme Holdings Pty Ltd")
business_api.business_name_check("The Coffee Collective")
```

### Email validation

```ruby
comms_api = client.communication

result = comms_api.email_validation("person@example.com")
result.valid       # => true
result.score       # => 0.48 (may be nil when unavailable)
result.free        # => true
result.disposable  # => false
```

### Phone validation

```ruby
result = comms_api.phone_validation("0412345678")
result.phone       # => "+61412345678"
result.country     # => "AU"
result.type        # => "mobile"
result.carrier     # => carrier name, when available
```

### Sanctions screening

```ruby
identity_api = client.identity

result = identity_api.sanctions_screening("Mohammad Hassan", birth_year: 1950, country: "AF")
result.match       # => true
result.results.first.confidence  # => 0.848
```

### TFN / Director ID validation

```ruby
identity_api.tfn_validation("123456782")
identity_api.director_id_validation("036123456789010")
```

### Account usage

```ruby
account_api = client.account
account = account_api.get_account
account.units_remaining  # => 48760
account.usage            # => { "autocomplete" => 520, "abn" => 295, ... }
```

## Bulk processing

Bulk processing requires an eligible Checkify subscription. JSON input accepts strings for
single-field endpoints or objects for endpoints such as reverse geocoding:

```ruby
batch_api = client.batch
job = batch_api.create_bulk_job(
  Checkify::BulkCreateRequest.new(endpoint: "abn", items: ["26008672179"])
)
batch_api.get_bulk_job(job.id)
```

For CSV upload, supply the endpoint and an open file as multipart form parameters:

```ruby
File.open("businesses.csv", "rb") do |file|
  job = batch_api.create_bulk_job(
    {},
    header_params: { "Content-Type" => "multipart/form-data" },
    form_params: { "endpoint" => "abn", "file" => file }
  )
end
```

Once a job completes, download its results and clean up the temporary file:

```ruby
require "fileutils"

file = batch_api.download_bulk_results(job.id)
begin
  FileUtils.cp(file.path, "results.csv")
ensure
  file.unlink
end
```

## Error handling

```ruby
begin
  result = business_api.abn_lookup("invalid")
rescue Checkify::ApiError => e
  e.code     # => 422
  e.response_body # => JSON containing the server error
  e.message       # => readable status, headers, and response body
end
```

The generated classes remain available for lower-level use. Configure their shared
defaults with `Checkify.configure`, or pass a `Checkify::ApiClient` constructed with
its own `Checkify::Configuration` to an endpoint class. `Checkify::Client` does not
change those shared defaults.

Redirects are followed by default. Pass `follow_location: false` to an endpoint
method to receive the redirect response as a `Checkify::ApiError` instead.

## API endpoints

All URIs are relative to `https://checkify.com.au/api/v1`.

| Class | Method | Endpoint | Description |
|---|---|---|---|
| `AccountApi` | `get_account` | `GET /account` | Account details and usage |
| `AddressApi` | `autocomplete` | `GET /autocomplete` | Address type-ahead search |
| `AddressApi` | `autocomplete_details` | `GET /autocomplete-details` | Full structured address |
| `AddressApi` | `autocomplete_suburb` | `GET /autocomplete-suburb` | Suburb type-ahead search |
| `AddressApi` | `autocomplete_suburb_details` | `GET /autocomplete-suburb-details` | Full suburb details |
| `AddressApi` | `postcode_lookup` | `GET /postcode` | Suburbs for a postcode |
| `AddressApi` | `reverse_geocode` | `GET /reverse` | Nearest address to coordinates |
| `BusinessApi` | `abn_lookup` | `GET /abn` | ABN validation and details |
| `BusinessApi` | `acn_lookup` | `GET /acn` | ACN validation and details |
| `BusinessApi` | `business_activity` | `GET /business-activity` | ANZSIC activity search |
| `BusinessApi` | `business_name_check` | `GET /business-name` | Business name availability |
| `BusinessApi` | `company_name_check` | `GET /company-name` | Company name availability |
| `CommunicationApi` | `email_validation` | `GET /email` | Email validation |
| `CommunicationApi` | `phone_validation` | `GET /phone` | Phone validation |
| `IdentityApi` | `sanctions_screening` | `GET /sanctions-screening` | Sanctions list screening |
| `IdentityApi` | `director_id_validation` | `GET /director-id` | Director ID checksum validation |
| `IdentityApi` | `tfn_validation` | `GET /tfn` | TFN checksum validation |
| `BatchApi` | `create_bulk_job` | `POST /bulk` | Submit bulk processing job |
| `BatchApi` | `get_bulk_job` | `GET /bulk/{id}` | Check bulk job status |
| `BatchApi` | `download_bulk_results` | `GET /bulk/{id}/download` | Download bulk results CSV |

## Development

```bash
bundle install
bundle exec rake
bundle exec rubocop
bundle exec rake build
```

The normal suite uses [VCR](https://github.com/vcr/vcr) to replay committed recordings
from `spec/fixtures/cassettes`. It does not load `.env` or contact Checkify, and fails
if a required recording is missing. The API recordings are genuine production
responses. Business fixtures use [Bunnings Group Limited (ABN 26 008 672 179)](https://abr.business.gov.au/ABN/View/26008672179).
Other examples use public addresses, Checkify's documented sample identifiers, and
`person@example.com`. Bulk tests use explicitly simulated responses because the
recording account does not have a bulk subscription; the multipart test verifies
libcurl's actual HTTP upload against a local test server.

### Recording against production

Set `CHECKIFY_API_KEY` in your environment or a local `.env` file; `.env.example`
shows the format. A private API key is recommended. Then explicitly enable recording:

```bash
CHECKIFY_RECORD=1 bundle exec rspec spec/api spec/api_client_spec.rb spec/client_spec.rb
```

This records missing interactions and replays existing ones. To refresh a particular
recording, remove that cassette first:

```bash
rm spec/fixtures/cassettes/business/abn_lookup.yml
CHECKIFY_RECORD=1 bundle exec rspec spec/api/business_api_spec.rb
```

To exercise the full recorded suite against production, remove `spec/fixtures/cassettes`
first and run the recording command. Review the resulting diff before committing.
Calls consume Checkify units and are paced below the free plan's rate limit. Bulk
specs remain simulated in recording mode. Public business responses are retained;
a recording hook removes credentials/cookies and redacts account usage and billing
dates. Never hand-edit recordings to make tests pass: fix the test inputs or recording
configuration, then record again. Old ignored files under `spec/cassettes` are unused.

### Regenerating the client

`openapi.yaml` is the locally maintained API contract, checked against
[Checkify's reference](https://checkify.com.au/developers). No downloadable upstream
OpenAPI document was available during the review on 5 September 2026.

Install OpenAPI Generator **7.21.0** and Java, then run:

```bash
bundle exec rake generate
bundle exec rake
```

`script/generate` uses `generator/config.yaml`, applies the multipart, redirect,
and timeout fixes to the upstream Ruby templates, regenerates the generated files
in `lib/` and `docs/`, and applies the project's lint rules. The handwritten
`lib/checkify/client.rb`, tests, gemspec, README, and CI are preserved.
Change the input spec or generator customization before regenerating; do not patch
generated library files directly. Regeneration removes obsolete generated files;
inspect the diff for removed or renamed schemas.

### Release checks

CI tests Ruby 3.3, 3.4, and 4.0, builds and loads the packaged gem, and scans Git history
for credentials. Run the suite, lint, `gem build checkify.gemspec`, and
`gitleaks git . --log-opts='--all' --redact` before publishing. The gem's explicit
file list excludes tests, recordings, credentials, and local notes.

Releases use [RubyGems Trusted Publishing](https://guides.rubygems.org/trusted-publishing/)
from `.github/workflows/release.yml` and the GitHub `release` environment. To release:

1. Set `gemVersion` in `generator/config.yaml`, regenerate, and update the changelog.
2. Commit the changes to `master` and wait for CI to pass.
3. Tag that commit with the matching version (for example, `v0.1.0`) and push the tag.

The release workflow reruns CI, verifies that the tag matches the gem version, and
publishes to RubyGems. No RubyGems API key is stored in the repository. Published
versions are immutable; subsequent changes need a new version and tag.

## License

This gem is available under the [MIT License](LICENSE).
