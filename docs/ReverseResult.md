# Checkify::ReverseResult

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **address_id** | **String** |  | [optional] |
| **address_full** | **String** |  | [optional] |
| **unit** | **String** |  | [optional] |
| **street_number** | **String** |  | [optional] |
| **street** | **String** |  | [optional] |
| **city** | **String** |  | [optional] |
| **postcode** | **String** |  | [optional] |
| **state** | **String** |  | [optional] |
| **latitude** | **Float** |  | [optional] |
| **longitude** | **Float** |  | [optional] |
| **distance_metres** | **Float** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::ReverseResult.new(
  address_id: null,
  address_full: null,
  unit: null,
  street_number: null,
  street: null,
  city: null,
  postcode: null,
  state: null,
  latitude: null,
  longitude: null,
  distance_metres: null
)
```

