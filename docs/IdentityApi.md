# Checkify::IdentityApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**director_id_validation**](IdentityApi.md#director_id_validation) | **GET** /director-id | Director ID validation |
| [**sanctions_screening**](IdentityApi.md#sanctions_screening) | **GET** /sanctions-screening | Sanctions screening |
| [**tfn_validation**](IdentityApi.md#tfn_validation) | **GET** /tfn | TFN validation |


## director_id_validation

> <DirectorIdResponse> director_id_validation(director_id)

Director ID validation

Validate the format and checksum of an Australian Director Identification Number using the official ABRS Damm algorithm. Structural check only — no live ABRS registry lookup. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::IdentityApi.new
director_id = 'director_id_example' # String | 15-digit Director ID starting with 036 — spaces accepted

begin
  # Director ID validation
  result = api_instance.director_id_validation(director_id)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->director_id_validation: #{e}"
end
```

#### Using the director_id_validation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DirectorIdResponse>, Integer, Hash)> director_id_validation_with_http_info(director_id)

```ruby
begin
  # Director ID validation
  data, status_code, headers = api_instance.director_id_validation_with_http_info(director_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DirectorIdResponse>
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->director_id_validation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **director_id** | **String** | 15-digit Director ID starting with 036 — spaces accepted |  |

### Return type

[**DirectorIdResponse**](DirectorIdResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## sanctions_screening

> <SanctionsResponse> sanctions_screening(name, opts)

Sanctions screening

Screen an individual or entity name against 11 sanctions and debarment lists including DFAT, UN, OFAC SDN, EU, UK OFSI, Canada, New Zealand, France, Hong Kong, World Bank, and IDB. Costs 3 units. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::IdentityApi.new
name = 'name_example' # String | Full name to screen (3–200 characters)
opts = {
  birth_year: 56, # Integer | Year of birth (1900–2008) — boosts confidence if matched
  country: 'country_example', # String | ISO 3166-1 alpha-2 country code — boosts confidence if matched
  city: 'city_example' # String | City of birth (max 200 characters) — fuzzy-compared for confidence boost
}

begin
  # Sanctions screening
  result = api_instance.sanctions_screening(name, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->sanctions_screening: #{e}"
end
```

#### Using the sanctions_screening_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<SanctionsResponse>, Integer, Hash)> sanctions_screening_with_http_info(name, opts)

```ruby
begin
  # Sanctions screening
  data, status_code, headers = api_instance.sanctions_screening_with_http_info(name, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <SanctionsResponse>
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->sanctions_screening_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Full name to screen (3–200 characters) |  |
| **birth_year** | **Integer** | Year of birth (1900–2008) — boosts confidence if matched | [optional] |
| **country** | **String** | ISO 3166-1 alpha-2 country code — boosts confidence if matched | [optional] |
| **city** | **String** | City of birth (max 200 characters) — fuzzy-compared for confidence boost | [optional] |

### Return type

[**SanctionsResponse**](SanctionsResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## tfn_validation

> <TfnResponse> tfn_validation(tfn)

TFN validation

Validate the format and checksum of an Australian Tax File Number. Structural check only — no live ATO registry lookup. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::IdentityApi.new
tfn = 'tfn_example' # String | 8 or 9-digit TFN — spaces and hyphens accepted

begin
  # TFN validation
  result = api_instance.tfn_validation(tfn)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->tfn_validation: #{e}"
end
```

#### Using the tfn_validation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<TfnResponse>, Integer, Hash)> tfn_validation_with_http_info(tfn)

```ruby
begin
  # TFN validation
  data, status_code, headers = api_instance.tfn_validation_with_http_info(tfn)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <TfnResponse>
rescue Checkify::ApiError => e
  puts "Error when calling IdentityApi->tfn_validation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **tfn** | **String** | 8 or 9-digit TFN — spaces and hyphens accepted |  |

### Return type

[**TfnResponse**](TfnResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

