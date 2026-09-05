# Checkify::AcnAddress

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Address type (registeredOffice, principalPlaceOfBusiness) | [optional] |
| **suburb** | **String** |  | [optional] |
| **state** | **String** |  | [optional] |
| **postcode** | **String** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AcnAddress.new(
  type: null,
  suburb: null,
  state: null,
  postcode: null
)
```

