# Checkify::BulkCreateRequestItems

## Class instance methods

### `openapi_one_of`

Returns the list of classes defined in oneOf.

#### Example

```ruby
require 'checkify'

Checkify::BulkCreateRequestItems.openapi_one_of
# =>
# [
#   :'Array<Object>',
#   :'Array<String>'
# ]
```

### build

Find the appropriate object from the `openapi_one_of` list and casts the data into it.

#### Example

```ruby
require 'checkify'

Checkify::BulkCreateRequestItems.build(data)
# => #<Array<Object>:0x00007fdd4aab02a0>

Checkify::BulkCreateRequestItems.build(data_that_doesnt_match)
# => nil
```

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| **data** | **Mixed** | data to be matched against the list of oneOf items |

#### Return type

- `Array<Object>`
- `Array<String>`
- `nil` (if no type matches)

