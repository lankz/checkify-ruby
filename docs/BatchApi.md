# Checkify::BatchApi

All URIs are relative to *https://checkify.com.au/api/v1*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_bulk_job**](BatchApi.md#create_bulk_job) | **POST** /bulk | Create bulk job |
| [**download_bulk_results**](BatchApi.md#download_bulk_results) | **GET** /bulk/{id}/download | Download bulk results |
| [**get_bulk_job**](BatchApi.md#get_bulk_job) | **GET** /bulk/{id} | Get bulk job status |


## create_bulk_job

> <BulkJob> create_bulk_job(bulk_create_request)

Create bulk job

Submit a batch of records for asynchronous processing. Supports ABN, ACN, TFN, Director ID, Email, Phone, Reverse Geocode, Address Validation, and Sanctions Screening. Each row consumes the same units as a single API call. Business & Enterprise plans only. 

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BatchApi.new
bulk_create_request = Checkify::BulkCreateRequest.new({endpoint: 'address-validation', items: nil}) # BulkCreateRequest | 

begin
  # Create bulk job
  result = api_instance.create_bulk_job(bulk_create_request)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->create_bulk_job: #{e}"
end
```

#### Using the create_bulk_job_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BulkJob>, Integer, Hash)> create_bulk_job_with_http_info(bulk_create_request)

```ruby
begin
  # Create bulk job
  data, status_code, headers = api_instance.create_bulk_job_with_http_info(bulk_create_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BulkJob>
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->create_bulk_job_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **bulk_create_request** | [**BulkCreateRequest**](BulkCreateRequest.md) |  |  |

### Return type

[**BulkJob**](BulkJob.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: application/json, multipart/form-data
- **Accept**: application/json


## download_bulk_results

> File download_bulk_results(id)

Download bulk results

Download the completed bulk job results as CSV.

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BatchApi.new
id = 56 # Integer | 

begin
  # Download bulk results
  result = api_instance.download_bulk_results(id)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->download_bulk_results: #{e}"
end
```

#### Using the download_bulk_results_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(File, Integer, Hash)> download_bulk_results_with_http_info(id)

```ruby
begin
  # Download bulk results
  data, status_code, headers = api_instance.download_bulk_results_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => File
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->download_bulk_results_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  |  |

### Return type

**File**

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/csv, application/json


## get_bulk_job

> <BulkJob> get_bulk_job(id)

Get bulk job status

Check the status of a bulk processing job.

### Examples

```ruby
require 'time'
require 'checkify'
# setup authorization
Checkify.configure do |config|
  # Configure Bearer authorization: BearerAuth
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = Checkify::BatchApi.new
id = 56 # Integer | 

begin
  # Get bulk job status
  result = api_instance.get_bulk_job(id)
  p result
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->get_bulk_job: #{e}"
end
```

#### Using the get_bulk_job_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BulkJob>, Integer, Hash)> get_bulk_job_with_http_info(id)

```ruby
begin
  # Get bulk job status
  data, status_code, headers = api_instance.get_bulk_job_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BulkJob>
rescue Checkify::ApiError => e
  puts "Error when calling BatchApi->get_bulk_job_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** |  |  |

### Return type

[**BulkJob**](BulkJob.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

