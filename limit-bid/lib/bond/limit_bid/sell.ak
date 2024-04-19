use aiken/dict
use aiken/transaction.{ScriptContext, Spend, Transaction, WithdrawFrom}
use aiken/transaction/credential.{Address, Inline, ScriptCredential}
use bond/limit_bid/types.{SellMulti, WithdrawAction} as dtypes
use common/types.{ScriptKeyHash} as ctypes

pub fn constraint(ctx: ScriptContext, multi_bid_sell_skh: ScriptKeyHash) {
  let tx = ctx.transaction
  expect Spend(ibid_out_ref) = ctx.purpose
  expect Some(ibid) = transaction.find_input(tx.inputs, ibid_out_ref)
  dict.foldl(
    tx.redeemers,
    False,
    fn(k, v, z) {
      when k is {
        WithdrawFrom(stake_cre) ->
          when stake_cre is {
            Inline(ScriptCredential(stake_skh)) ->
              if stake_skh == multi_bid_sell_skh {
                expect r: WithdrawAction = v
                let SellMulti(bid_skh) = r
                if
                ScriptCredential(bid_skh) == ibid.output.address.payment_credential{
                
                  True
                } else {
                  fail @"redeemer is invalid"
                }
              } else {
                z
              }
            _ -> z
          }
        _ -> z
      }
    },
  )
}
