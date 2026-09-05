# Checkify::PhoneResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **phone** | **String** | E.164 format | [optional] |
| **phone_national** | **String** | National format as dialled locally | [optional] |
| **phone_international** | **String** | International format with country code | [optional] |
| **valid** | **Boolean** |  | [optional] |
| **country** | **String** | Detected ISO 3166-1 alpha-2 country code | [optional] |
| **type** | **String** | Line type: mobile, fixed-line, toll-free, voip, etc. | [optional] |
| **carrier** | **String** |  | [optional] |
| **location** | **String** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::PhoneResponse.new(
  phone: null,
  phone_national: null,
  phone_international: null,
  valid: null,
  country: null,
  type: null,
  carrier: null,
  location: null
)
```

