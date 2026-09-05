# Checkify::AddressApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**autocomplete**](AddressApi.md#autocomplete) | **GET** /autocomplete | Address autocomplete |
| [**autocomplete_details**](AddressApi.md#autocomplete_details) | **GET** /autocomplete-details | Address details |
| [**autocomplete_suburb**](AddressApi.md#autocomplete_suburb) | **GET** /autocomplete-suburb | Suburb autocomplete |
| [**autocomplete_suburb_details**](AddressApi.md#autocomplete_suburb_details) | **GET** /autocomplete-suburb-details | Suburb details |
| [**postcode_lookup**](AddressApi.md#postcode_lookup) | **GET** /postcode | Postcode lookup |
| [**reverse_geocode**](AddressApi.md#reverse_geocode) | **GET** /reverse | Reverse geocode |


## autocomplete

> Hash&lt;String, String&gt; autocomplete(query, opts)

Address autocomplete

Type-ahead address search across 17.8 M+ Australian and New Zealand addresses. Returns a map of address IDs to highlighted HTML strings. Costs 0 units. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
query = 'query_example' # String | Search term, min 3 characters
opts = {
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Address autocomplete
  result = api_instance.autocomplete(query, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete: #{e}"
end
```

#### Using the autocomplete_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Hash&lt;String, String&gt;, Integer, Hash)> autocomplete_with_http_info(query, opts)

```ruby
begin
  # Address autocomplete
  data, status_code, headers = api_instance.autocomplete_with_http_info(query, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Hash&lt;String, String&gt;
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **query** | **String** | Search term, min 3 characters |  |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

**Hash&lt;String, String&gt;**

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## autocomplete_details

> <AddressDetails> autocomplete_details(id, opts)

Address details

Fetch the full structured record for an address ID returned by /autocomplete. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
id = 'id_example' # String | Address ID from /autocomplete
opts = {
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Address details
  result = api_instance.autocomplete_details(id, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_details: #{e}"
end
```

#### Using the autocomplete_details_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AddressDetails>, Integer, Hash)> autocomplete_details_with_http_info(id, opts)

```ruby
begin
  # Address details
  data, status_code, headers = api_instance.autocomplete_details_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AddressDetails>
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_details_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Address ID from /autocomplete |  |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

[**AddressDetails**](AddressDetails.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## autocomplete_suburb

> Hash&lt;String, String&gt; autocomplete_suburb(query, opts)

Suburb autocomplete

Search for suburbs and localities across Australia and New Zealand. Returns a map of locality IDs to highlighted strings. Costs 0 units. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
query = 'query_example' # String | Search term, min 2 characters
opts = {
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Suburb autocomplete
  result = api_instance.autocomplete_suburb(query, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_suburb: #{e}"
end
```

#### Using the autocomplete_suburb_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Hash&lt;String, String&gt;, Integer, Hash)> autocomplete_suburb_with_http_info(query, opts)

```ruby
begin
  # Suburb autocomplete
  data, status_code, headers = api_instance.autocomplete_suburb_with_http_info(query, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Hash&lt;String, String&gt;
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_suburb_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **query** | **String** | Search term, min 2 characters |  |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

**Hash&lt;String, String&gt;**

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## autocomplete_suburb_details

> <SuburbDetails> autocomplete_suburb_details(id, opts)

Suburb details

Get full details for a locality ID returned by /autocomplete-suburb. Costs 1 unit. For NZ results, state/stateFull are null; use region instead. NZ localities return postcode: null. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
id = 'id_example' # String | Locality ID from /autocomplete-suburb
opts = {
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Suburb details
  result = api_instance.autocomplete_suburb_details(id, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_suburb_details: #{e}"
end
```

#### Using the autocomplete_suburb_details_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<SuburbDetails>, Integer, Hash)> autocomplete_suburb_details_with_http_info(id, opts)

```ruby
begin
  # Suburb details
  data, status_code, headers = api_instance.autocomplete_suburb_details_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <SuburbDetails>
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->autocomplete_suburb_details_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Locality ID from /autocomplete-suburb |  |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

[**SuburbDetails**](SuburbDetails.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## postcode_lookup

> <Array<PostcodeResult>> postcode_lookup(postcode, opts)

Postcode lookup

Look up all suburbs and localities that belong to a postcode. Returns up to 50 results ordered alphabetically. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
postcode = 'postcode_example' # String | 4-digit postcode
opts = {
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Postcode lookup
  result = api_instance.postcode_lookup(postcode, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->postcode_lookup: #{e}"
end
```

#### Using the postcode_lookup_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<PostcodeResult>>, Integer, Hash)> postcode_lookup_with_http_info(postcode, opts)

```ruby
begin
  # Postcode lookup
  data, status_code, headers = api_instance.postcode_lookup_with_http_info(postcode, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<PostcodeResult>>
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->postcode_lookup_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **postcode** | **String** | 4-digit postcode |  |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

[**Array&lt;PostcodeResult&gt;**](PostcodeResult.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## reverse_geocode

> <Array<ReverseResult>> reverse_geocode(lat, lng, opts)

Reverse geocode

Find the nearest address(es) to a coordinate pair. Results are ordered by distance. Costs 1 unit. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::AddressApi.new
lat = 1.2 # Float | Latitude (AU: −44 to −9, NZ: −47 to −34)
lng = 1.2 # Float | Longitude (AU: 112–155, NZ: 166–178)
opts = {
  radius: 56, # Integer | Search radius in metres (1–5000, default 100)
  limit: 56, # Integer | Max results (1–10, default 1)
  country: 'au' # String | Country dataset: au (default) or nz
}

begin
  # Reverse geocode
  result = api_instance.reverse_geocode(lat, lng, opts)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->reverse_geocode: #{e}"
end
```

#### Using the reverse_geocode_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<ReverseResult>>, Integer, Hash)> reverse_geocode_with_http_info(lat, lng, opts)

```ruby
begin
  # Reverse geocode
  data, status_code, headers = api_instance.reverse_geocode_with_http_info(lat, lng, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<ReverseResult>>
rescue Checkify::ApiError => e
  puts "Error when calling AddressApi->reverse_geocode_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **lat** | **Float** | Latitude (AU: −44 to −9, NZ: −47 to −34) |  |
| **lng** | **Float** | Longitude (AU: 112–155, NZ: 166–178) |  |
| **radius** | **Integer** | Search radius in metres (1–5000, default 100) | [optional][default to 100] |
| **limit** | **Integer** | Max results (1–10, default 1) | [optional][default to 1] |
| **country** | **String** | Country dataset: au (default) or nz | [optional][default to &#39;au&#39;] |

### Return type

[**Array&lt;ReverseResult&gt;**](ReverseResult.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

