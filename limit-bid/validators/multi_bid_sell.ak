// Bid Limit Multi Withdraw
use aiken/transaction.{ScriptContext, WithdrawFrom}
use bond/limit_bid/multi_bid_sell
use bond/limit_bid/types.{SellMulti, WithdrawAction} as ctypes
use bond/types.{BondConfigLimitRaw, bond_config_limit_from_raw} as bond_types
use common/types.{ScriptKeyHash}

validator(cfg: BondConfigLimitRaw, deprecated_bid_skh: List<ScriptKeyHash>) {
  fn bid_multi(redeemer: WithdrawAction, ctx: ScriptContext) -> Bool {
    when ctx.purpose is {
      WithdrawFrom { .. } -> {
        let SellMulti(bid_skh) = redeemer
        multi_bid_sell.constraint(
          ctx,
          bond_config_limit_from_raw(cfg),
          bid_skh,
          deprecated_bid_skh,
        )
      }
      _ -> False
    }
  }
}
