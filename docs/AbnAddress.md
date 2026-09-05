# Checkify::AbnAddress

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Address type (e.g. serviceAddress) | [optional] |
| **state** | **String** |  | [optional] |
| **postcode** | **String** |  | [optional] |
| **active_from** | **Date** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AbnAddress.new(
  type: null,
  state: null,
  postcode: null,
  active_from: null
)
```

