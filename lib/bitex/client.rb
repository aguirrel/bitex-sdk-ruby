module Bitex
  # This client connects via Json API resources.
  class Client
    attr_reader :api_key, :sandbox

    def initialize(api_key: nil, sandbox: false)
      @api_key = api_key
      @sandbox = sandbox
    end

    [
      Resources::Orderbook, Resources::Ticker, Resources::Market, Resources::Transaction, Resources::Candle,

      Resources::Orders::Order, Resources::Orders::Ask, Resources::Orders::Bid,

      Resources::TradingBots::BuyingBot, Resources::TradingBots::SellingBot,

      Resources::Trades::Trade, Resources::Trades::Buy, Resources::Trades::Sell,

      Resources::Wallets::CashWallet, Resources::Wallets::CoinWallet,

      Resources::Deposits::CashDeposit, Resources::Deposits::CoinDeposit,
      Resources::Withdrawals::WithdrawalInstruction, Resources::Withdrawals::CashWithdrawal,
      Resources::Withdrawals::CoinWithdrawal,

      Resources::Merchants::Payment, Resources::Merchants::Pos,

      Resources::ApiKey,

      Resources::Compliance::AllowanceSeed, Resources::Compliance::NaturalDocketSeed, Resources::Compliance::IdentificationSeed,
      Resources::Compliance::NoteSeed, Resources::Compliance::DomicileSeed, Resources::Compliance::EmailSeed,
      Resources::Compliance::PhoneSeed,
      Resources::Compliance::ArgentinaInvoicingDetailSeed, Resources::Compliance::ChileInvoicingDetailSeed,

      Resources::Miscellaneous::Account, Resources::Miscellaneous::Movement
    ].each do |resource|
      accessor = resource.name.demodulize.underscore.downcase.pluralize

      define_method(accessor) do
        instance_variable_get("@#{accessor}") ||
          instance_variable_set("@#{accessor}", resource.build(api_key: api_key, sandbox: sandbox))
      end
    end
  end
end
