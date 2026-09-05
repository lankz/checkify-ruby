# Checkify::AbnResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **abn** | **String** |  | [optional] |
| **abn_formatted** | **String** |  | [optional] |
| **acn** | **String** |  | [optional] |
| **acn_formatted** | **String** |  | [optional] |
| **entity_name** | **String** |  | [optional] |
| **entity_type** | **String** |  | [optional] |
| **abn_details** | [**AbnResponseAbnDetails**](AbnResponseAbnDetails.md) |  | [optional] |
| **addresses** | [**Array&lt;AbnAddress&gt;**](AbnAddress.md) |  | [optional] |
| **business_names** | **Array&lt;String&gt;** |  | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::AbnResponse.new(
  abn: null,
  abn_formatted: null,
  acn: null,
  acn_formatted: null,
  entity_name: null,
  entity_type: null,
  abn_details: null,
  addresses: null,
  business_names: null
)
```

