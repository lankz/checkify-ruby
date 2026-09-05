# Checkify::SanctionsResult

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **source** | **String** | Source sanctions list | [optional] |
| **reference** | **String** | Source-specific reference number | [optional] |
| **name** | **String** | Primary name of the sanctioned individual or entity | [optional] |
| **type** | **String** |  | [optional] |
| **aliases** | **Array&lt;String&gt;** |  | [optional] |
| **confidence** | **Float** | Confidence score — higher when birth details match | [optional] |
| **sanctions** | [**SanctionsResultSanctions**](SanctionsResultSanctions.md) |  | [optional] |
| **date_of_birth** | **String** |  | [optional] |
| **place_of_birth** | **String** |  | [optional] |
| **citizenship** | **String** |  | [optional] |
| **committees** | **String** |  | [optional] |
| **listing_information** | **String** |  | [optional] |
| **source_updated_at** | **String** | Date of last source list update | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::SanctionsResult.new(
  source: null,
  reference: null,
  name: null,
  type: null,
  aliases: null,
  confidence: null,
  sanctions: null,
  date_of_birth: null,
  place_of_birth: null,
  citizenship: null,
  committees: null,
  listing_information: null,
  source_updated_at: null
)
```

