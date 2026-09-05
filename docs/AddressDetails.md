# Checkify::AddressDetails

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **unit** | **String** | Flat/unit number and type | [optional] |
| **level** | **String** | Floor/level descriptor | [optional] |
| **unit_level** | **String** | Combined unit and level | [optional] |
| **street_number** | **String** | House/lot number | [optional] |
| **street_name** | **String** | Street name only | [optional] |
| **street_type** | **String** | Street type code (ST, RD, AVE…) | [optional] |
| **street** | **String** | Number + full street name combined | [optional] |
| **city** | **String** | Locality/suburb name | [optional] |
| **postcode** | **String** | 4-digit postcode | [optional] |
| **state** | **String** | State abbreviation (NSW, VIC…) — AU only | [optional] |
| **state_full** | **String** | Full state name — AU only | [optional] |
| **region** | **String** | Region/city (e.g. Auckland) — NZ only | [optional] |
| **country** | **String** | Country code (AU or NZ) | [optional] |
| **country_full** | **String** | Full country name | [optional] |
| **latitude** | **Float** |  | [optional] |
| **longitude** | **Float** |  | [optional] |
| **mesh_block_code** | **String** | ABS Mesh Block identifier — AU only | [optional] |
| **building_name** | **String** | Named building or complex — AU only | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AddressDetails.new(
  unit: null,
  level: null,
  unit_level: null,
  street_number: null,
  street_name: null,
  street_type: null,
  street: null,
  city: null,
  postcode: null,
  state: null,
  state_full: null,
  region: null,
  country: null,
  country_full: null,
  latitude: null,
  longitude: null,
  mesh_block_code: null,
  building_name: null
)
```

