module Bitex
  module Resources
    autoload :Public, 'bitex/resources/public'

    autoload :Orderbook, 'bitex/resources/public/orderbook'
    autoload :Ticker, 'bitex/resources/public/ticker'
    autoload :Market, 'bitex/resources/public/market'
    autoload :OrderGroup, 'bitex/resources/public/order_group'
    autoload :Candle, 'bitex/resources/public/candle'
    autoload :Transaction, 'bitex/resources/public/transaction'

    autoload :Private, 'bitex/resources/private'

    autoload :Order, 'bitex/resources/private/order'
    autoload :Bid, 'bitex/resources/private/order/bid'
    autoload :Ask, 'bitex/resources/private/order/ask'

    autoload :Trade, 'bitex/resources/private/trade'
    autoload :Buy, 'bitex/resources/private/trade/buy'
    autoload :Sell, 'bitex/resources/private/trade/sell'

    autoload :TradingBot, 'bitex/resources/private/trading_bot'
    autoload :BuyingBot, 'bitex/resources/private/trading_bot/buying_bot'
    autoload :SellingBot, 'bitex/resources/private/trading_bot/selling_bot'

    autoload :Deposit, 'bitex/resources/private/deposit'
    autoload :CashDeposit, 'bitex/resources/private/deposit/cash_deposit'
    autoload :CoinDeposit, 'bitex/resources/private/deposit/coin_deposit'

    autoload :CashDepositInstruction, 'bitex/resources/private/cash_deposit_instruction'

    autoload :Wallet, 'bitex/resources/private/wallet'
    autoload :CashWallet, 'bitex/resources/private/wallet/cash_wallet'
    autoload :CoinWallet, 'bitex/resources/private/wallet/coin_wallet'

    autoload :WithdrawalInstruction, 'bitex/resources/private/withdrawal_instruction'
  end
end
