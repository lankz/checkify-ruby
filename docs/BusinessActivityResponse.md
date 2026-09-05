# Checkify::BusinessActivityResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** |  | [optional] |
| **count** | **Integer** |  | [optional] |
| **activities** | [**Array&lt;BusinessActivity&gt;**](BusinessActivity.md) |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::BusinessActivityResponse.new(
  status: null,
  count: null,
  activities: null
)
```

