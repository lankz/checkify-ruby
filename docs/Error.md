# Checkify::Error

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **message** | **String** |  | [optional] |
| **errors** | **Hash&lt;String, Array&lt;String&gt;&gt;** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::Error.new(
  error: null,
  message: null,
  errors: null
)
```

