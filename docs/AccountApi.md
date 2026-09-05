# Checkify::AccountApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_account**](AccountApi.md#get_account) | **GET** /account | Get account details |


## get_account

> <Account> get_account

Get account details

Returns your current plan, unit usage, billing period, subscription status, and a per-endpoint breakdown of API calls for the current period. Costs 0 units. Usage breakdown is cached for 5 minutes. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AccountApi.new

begin
  # Get account details
  result = api_instance.get_account
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AccountApi->get_account: #{e}"
end
```

#### Using the get_account_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Account>, Integer, Hash)> get_account_with_http_info

```ruby
begin
  # Get account details
  data, status_code, headers = api_instance.get_account_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Account>
rescue Checkify::ApiError => e
  puts "Error when calling AccountApi->get_account_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Account**](Account.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

