// Bid Limit Multi
use aiken/transaction.{ScriptContext}
use bond/limit_bid/sell
use bond/limit_bid/types.{Sell, TradeAction, Update} as ctypes
use bond/types.{BidLimitMulti}
use common/types.{ScriptKeyHash} as common_types
use common/util.{must_be_signed_by_key} as common_utils

validator(multi_bid_sell_skh: ScriptKeyHash) {
  fn bid_multi(sdt: BidLimitMulti, ac: TradeAction, ctx: ScriptContext) -> Bool {
    when ac is {
      Update ->
        must_be_signed_by_key(ctx.transaction.extra_signatories, sdt.owner_vk)?
      Sell { .. } -> sell.constraint(ctx, multi_bid_sell_skh)
      _ -> False
    }
  }
}
