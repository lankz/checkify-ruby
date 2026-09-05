# Checkify::DirectorIdResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **director_id** | **String** | Normalised digits only | [optional] |
| **director_id_formatted** | **String** | Grouped with spaces | [optional] |
| **valid** | **Boolean** |  | [optional] |
| **notice** | **String** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::DirectorIdResponse.new(
  director_id: null,
  director_id_formatted: null,
  valid: null,
  notice: null
)
```

