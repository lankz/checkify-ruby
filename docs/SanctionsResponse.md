# Checkify::SanctionsResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **match** | **Boolean** | true if any results meet the confidence threshold | [optional] |
| **results** | [**Array&lt;SanctionsResult&gt;**](SanctionsResult.md) |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::SanctionsResponse.new(
  match: null,
  results: null
)
```

