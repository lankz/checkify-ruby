# Checkify::AsicDocument

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **number** | **String** |  | [optional] |
| **date** | **Date** |  | [optional] |
| **code** | **String** |  | [optional] |
| **title** | **String** |  | [optional] |
| **pages** | **Integer** |  | [optional] |
| **contents** | [**Array&lt;AsicDocumentContentsInner&gt;**](AsicDocumentContentsInner.md) |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AsicDocument.new(
  number: null,
  date: null,
  code: null,
  title: null,
  pages: null,
  contents: null
)
```

