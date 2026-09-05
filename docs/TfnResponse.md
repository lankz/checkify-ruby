# Checkify::TfnResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **tfn** | **String** | Normalised digits only | [optional] |
| **tfn_formatted** | **String** | Grouped with spaces | [optional] |
| **valid** | **Boolean** |  | [optional] |
| **notice** | **String** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::TfnResponse.new(
  tfn: null,
  tfn_formatted: null,
  valid: null,
  notice: null
)
```

