# Checkify::BusinessApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**abn_lookup**](BusinessApi.md#abn_lookup) | **GET** /abn | ABN lookup |
| [**acn_lookup**](BusinessApi.md#acn_lookup) | **GET** /acn | ACN lookup |
| [**business_activity**](BusinessApi.md#business_activity) | **GET** /business-activity | Business activity search |
| [**business_name_check**](BusinessApi.md#business_name_check) | **GET** /business-name | Business name availability |
| [**company_name_check**](BusinessApi.md#company_name_check) | **GET** /company-name | Company name availability |


## abn_lookup

> <AbnResponse> abn_lookup(abn)

ABN lookup

Validate an Australian Business Number and retrieve registered business details from the ABR. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BusinessApi.new
abn = 'abn_example' # String | 11-digit ABN — spaces accepted

begin
  # ABN lookup
  result = api_instance.abn_lookup(abn)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->abn_lookup: #{e}"
end
```

#### Using the abn_lookup_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AbnResponse>, Integer, Hash)> abn_lookup_with_http_info(abn)

```ruby
begin
  # ABN lookup
  data, status_code, headers = api_instance.abn_lookup_with_http_info(abn)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AbnResponse>
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->abn_lookup_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **abn** | **String** | 11-digit ABN — spaces accepted |  |

### Return type

[**AbnResponse**](AbnResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## acn_lookup

> <AcnResponse> acn_lookup(acn)

ACN lookup

Validate an Australian Company Number and retrieve registered company details from ASIC, including entity name, type, registration dates, addresses, former names, and recent documents. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BusinessApi.new
acn = 'acn_example' # String | 9-digit ACN — spaces accepted

begin
  # ACN lookup
  result = api_instance.acn_lookup(acn)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->acn_lookup: #{e}"
end
```

#### Using the acn_lookup_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AcnResponse>, Integer, Hash)> acn_lookup_with_http_info(acn)

```ruby
begin
  # ACN lookup
  data, status_code, headers = api_instance.acn_lookup_with_http_info(acn)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AcnResponse>
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->acn_lookup_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **acn** | **String** | 9-digit ACN — spaces accepted |  |

### Return type

[**AcnResponse**](AcnResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## business_activity

> <BusinessActivityResponse> business_activity(search, opts)

Business activity search

Search over 9,000 Australian business activities and industry classifications (ANZSIC codes) with fuzzy matching, misspelling correction, and relevance scoring. Costs 0 units. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BusinessApi.new
search = 'search_example' # String | Search query, min 3 characters
opts = {
  limit: 56 # Integer | Max results (1–100, default 25)
}

begin
  # Business activity search
  result = api_instance.business_activity(search, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->business_activity: #{e}"
end
```

#### Using the business_activity_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BusinessActivityResponse>, Integer, Hash)> business_activity_with_http_info(search, opts)

```ruby
begin
  # Business activity search
  data, status_code, headers = api_instance.business_activity_with_http_info(search, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BusinessActivityResponse>
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->business_activity_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **search** | **String** | Search query, min 3 characters |  |
| **limit** | **Integer** | Max results (1–100, default 25) | [optional][default to 25] |

### Return type

[**BusinessActivityResponse**](BusinessActivityResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## business_name_check

> <NameAvailability> business_name_check(name)

Business name availability

Check whether a proposed business (trading) name is available for registration with ASIC. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BusinessApi.new
name = 'name_example' # String | Proposed business name (max 200 characters)

begin
  # Business name availability
  result = api_instance.business_name_check(name)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->business_name_check: #{e}"
end
```

#### Using the business_name_check_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NameAvailability>, Integer, Hash)> business_name_check_with_http_info(name)

```ruby
begin
  # Business name availability
  data, status_code, headers = api_instance.business_name_check_with_http_info(name)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NameAvailability>
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->business_name_check_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Proposed business name (max 200 characters) |  |

### Return type

[**NameAvailability**](NameAvailability.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## company_name_check

> <NameAvailability> company_name_check(name)

Company name availability

Check whether a proposed company name is available for registration with ASIC. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BusinessApi.new
name = 'name_example' # String | Proposed company name (max 200 characters)

begin
  # Company name availability
  result = api_instance.company_name_check(name)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->company_name_check: #{e}"
end
```

#### Using the company_name_check_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NameAvailability>, Integer, Hash)> company_name_check_with_http_info(name)

```ruby
begin
  # Company name availability
  data, status_code, headers = api_instance.company_name_check_with_http_info(name)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NameAvailability>
rescue Checkify::ApiError => e
  puts "Error when calling BusinessApi->company_name_check_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Proposed company name (max 200 characters) |  |

### Return type

[**NameAvailability**](NameAvailability.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

