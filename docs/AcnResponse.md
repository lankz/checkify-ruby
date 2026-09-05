# Checkify::AcnResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **abn** | **String** |  | [optional] |
| **abn_formatted** | **String** |  | [optional] |
| **acn** | **String** |  | [optional] |
| **acn_formatted** | **String** |  | [optional] |
| **entity_name** | **String** |  | [optional] |
| **entity_type** | **String** |  | [optional] |
| **abn_details** | [**AcnResponseAbnDetails**](AcnResponseAbnDetails.md) |  | [optional] |
| **acn_details** | [**AcnResponseAcnDetails**](AcnResponseAcnDetails.md) |  | [optional] |
| **addresses** | [**Array&lt;AcnAddress&gt;**](AcnAddress.md) |  | [optional] |
| **former_names** | [**Array&lt;FormerName&gt;**](FormerName.md) |  | [optional] |
| **documents** | [**Array&lt;AsicDocument&gt;**](AsicDocument.md) |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AcnResponse.new(
  abn: null,
  abn_formatted: null,
  acn: null,
  acn_formatted: null,
  entity_name: null,
  entity_type: null,
  abn_details: null,
  acn_details: null,
  addresses: null,
  former_names: null,
  documents: null
)
```

