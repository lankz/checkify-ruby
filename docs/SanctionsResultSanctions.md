# Checkify::SanctionsResultSanctions

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **targeted_financial_sanction** | **Boolean** |  | [optional] |
| **travel_ban** | **Boolean** |  | [optional] |
| **arms_embargo** | **Boolean** |  | [optional] |
| **maritime_restriction** | **Boolean** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::SanctionsResultSanctions.new(
  targeted_financial_sanction: null,
  travel_ban: null,
  arms_embargo: null,
  maritime_restriction: null
)
```

