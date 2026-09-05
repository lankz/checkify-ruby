# Checkify::SuburbDetails

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **city** | **String** |  | [optional] |
| **postcode** | **String** | 4-digit postcode (null for NZ) | [optional] |
| **state** | **String** | State abbreviation — AU only | [optional] |
| **state_full** | **String** | Full state name — AU only | [optional] |
| **region** | **String** | Region/city — NZ only | [optional] |
| **country** | **String** |  | [optional] |
| **country_full** | **String** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::SuburbDetails.new(
  city: null,
  postcode: null,
  state: null,
  state_full: null,
  region: null,
  country: null,
  country_full: null
)
```

