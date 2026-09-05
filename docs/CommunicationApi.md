# Checkify::CommunicationApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**email_validation**](CommunicationApi.md#email_validation) | **GET** /email | Email validation |
| [**phone_validation**](CommunicationApi.md#phone_validation) | **GET** /phone | Phone validation |


## email_validation

> <EmailResponse> email_validation(email)

Email validation

Validate an email address — checks RFC format, DNS/MX records, SMTP deliverability, disposable/free/role detection, and quality score. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::CommunicationApi.new
email = 'email_example' # String | Email address to validate (max 254 characters)

begin
  # Email validation
  result = api_instance.email_validation(email)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling CommunicationApi->email_validation: #{e}"
end
```

#### Using the email_validation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<EmailResponse>, Integer, Hash)> email_validation_with_http_info(email)

```ruby
begin
  # Email validation
  data, status_code, headers = api_instance.email_validation_with_http_info(email)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <EmailResponse>
rescue Checkify::ApiError => e
  puts "Error when calling CommunicationApi->email_validation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **email** | **String** | Email address to validate (max 254 characters) |  |

### Return type

[**EmailResponse**](EmailResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## phone_validation

> <PhoneResponse> phone_validation(phone, opts)

Phone validation

Validate and normalise a phone number. Detects country, returns E.164 / national / international formats, line type, carrier, and location. Defaults to AU parsing. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::CommunicationApi.new
phone = 'phone_example' # String | Phone number to validate — include country code or use the country hint
opts = {
  country: 'country_example' # String | ISO 3166-1 alpha-2 country code hint for local numbers (default AU)
}

begin
  # Phone validation
  result = api_instance.phone_validation(phone, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling CommunicationApi->phone_validation: #{e}"
end
```

#### Using the phone_validation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PhoneResponse>, Integer, Hash)> phone_validation_with_http_info(phone, opts)

```ruby
begin
  # Phone validation
  data, status_code, headers = api_instance.phone_validation_with_http_info(phone, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PhoneResponse>
rescue Checkify::ApiError => e
  puts "Error when calling CommunicationApi->phone_validation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **phone** | **String** | Phone number to validate — include country code or use the country hint |  |
| **country** | **String** | ISO 3166-1 alpha-2 country code hint for local numbers (default AU) | [optional][default to &#39;AU&#39;] |

### Return type

[**PhoneResponse**](PhoneResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

