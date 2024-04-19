use aiken/transaction/value.{AssetName, PolicyId}
use bond/types.{BondType}
use common/types.{Lovelace, ScriptKeyHash} as common_types

pub type TradeAction {
  Update
  Buy
  Sell {
    exchange_fee: Lovelace,
    seller_receive: Lovelace,
    offers: List<(PolicyId, AssetName, Int)>,
    cont_idx: Option<Int>,
  }
  Upgrade
  GarbageCollector
}

pub type WithdrawAction {
  SellMulti { bid_skh: ScriptKeyHash }
}

pub type EscrowInfo {
  bond_symbol: PolicyId,
  token_name: AssetName,
  bond_amount: Int,
  start_epoch: Int,
  end_epoch: Int,
  value_at_maturity: Int,
  day_to_maturity: Int,
  bond_type: BondType,
}
