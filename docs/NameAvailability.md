# Checkify::NameAvailability

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Normalised (uppercased) name | [optional] |
| **availability** | **String** | Availability status (e.g. Available) | [optional] |
| **short_description** | **String** |  | [optional] |
| **objections** | **Array&lt;String&gt;** |  | [optional] |
| **existing_business_name** | **Boolean** | Whether the name already exists as a registered business name | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::NameAvailability.new(
  name: null,
  availability: null,
  short_description: null,
  objections: null,
  existing_business_name: null
)
```

