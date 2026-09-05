# Checkify::EmailResponseFormat

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **valid** | **Boolean** |  | [optional] |
| **account** | **String** | Local part (before @) | [optional] |
| **domain** | **String** | Domain part (after @) | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::EmailResponseFormat.new(
  valid: null,
  account: null,
  domain: null
)
```

