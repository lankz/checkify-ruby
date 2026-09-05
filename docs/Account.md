# Checkify::Account

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **plan** | **String** |  | [optional] |
| **plan_name** | **String** |  | [optional] |
| **status** | **String** |  | [optional] |
| **cancels_at** | **Date** | ISO 8601 date when subscription ends (only when status is cancelling) | [optional] |
| **units_used** | **Integer** |  | [optional] |
| **units_limit** | **Integer** |  | [optional] |
| **units_remaining** | **Integer** |  | [optional] |
| **period_start** | **Date** |  | [optional] |
| **period_end** | **Date** |  | [optional] |
| **usage** | **Hash&lt;String, Integer&gt;** | Per-endpoint call counts for the current period | [optional] |

## Example

```ruby
require 'checkify'

instance = Checkify::Account.new(
  plan: null,
  plan_name: null,
  status: null,
  cancels_at: null,
  units_used: null,
  units_limit: null,
  units_remaining: null,
  period_start: null,
  period_end: null,
  usage: null
)
```

