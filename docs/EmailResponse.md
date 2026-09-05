# Checkify::EmailResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **email** | **String** | Normalised (lowercased) email address | [optional] |
| **valid** | **Boolean** | true only if both format and DNS checks pass | [optional] |
| **format** | [**EmailResponseFormat**](EmailResponseFormat.md) |  | [optional] |
| **dns** | [**EmailResponseDns**](EmailResponseDns.md) |  | [optional] |
| **deliverable** | **Boolean** |  | [optional] |
| **can_connect_smtp** | **Boolean** |  | [optional] |
| **inbox_full** | **Boolean** |  | [optional] |
| **disabled** | **Boolean** |  | [optional] |
| **catch_all** | **Boolean** |  | [optional] |
| **score** | **Float** | Quality score — higher is better | [optional] |
| **free** | **Boolean** | Whether the email uses a free provider | [optional] |
| **disposable** | **Boolean** | Whether the email uses a disposable/temporary provider | [optional] |
| **role** | **Boolean** | Whether this is a role-based address (e.g. support@, info@) | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::EmailResponse.new(
  email: null,
  valid: null,
  format: null,
  dns: null,
  deliverable: null,
  can_connect_smtp: null,
  inbox_full: null,
  disabled: null,
  catch_all: null,
  score: null,
  free: null,
  disposable: null,
  role: null
)
```

