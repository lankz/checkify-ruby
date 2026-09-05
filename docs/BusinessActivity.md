# Checkify::BusinessActivity

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Unique activity identifier | [optional] |
| **industry_code** | **String** | ANZSIC industry classification code | [optional] |
| **full_name** | **String** | Business activity description | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::BusinessActivity.new(
  code: null,
  industry_code: null,
  full_name: null
)
```

