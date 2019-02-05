# Cast to decimal balances from float balances.
class BalancesCaster
  def self.cast(balances, _default)
    balances.each { |code, balance| balances[code] = balance_caster(balance) }.with_indifferent_access
  end

  def self.balance_caster(balance)
    { total: balance['total'].to_d, available: balance['available'].to_d }
  end

  private_class_method :balance_caster
end

JsonApiClient::Schema.register balances: BalancesCaster
