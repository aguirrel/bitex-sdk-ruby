module Bitex
  # This client connects via Json API resources.
  class Client
    include Resources
    include Compliance
    include Miscellaneous

    attr_reader :api_key, :sandbox

    def initialize(api_key: nil, sandbox: false)
      @api_key = api_key
      @sandbox = sandbox
    end

    [
      Orderbook, Ticker, Market, Transaction, Candle, Order, Ask, Bid, Trade, Buy, Sell, BuyingBot, SellingBot,
    CashDeposit, CoinDeposit, CashDepositInstruction, CashWallet, CoinWallet, WithdrawalInstruction, CashWithdrawal,
    CoinWithdrawal, Payment, Pos, ApiKey, AllowanceSeed, NaturalDocketSeed, IdentificationSeed, NoteSeed, DomicileSeed,
    EmailSeed, ArgentinaInvoicingDetailSeed, ChileInvoicingDetailSeed, PhoneSeed, Movement, Account
    ].each do |resource|
      accessor = resource.name.demodulize.underscore.downcase.pluralize

      define_method(accessor) do
        instance_variable_get("@#{accessor}") || instance_variable_set("@#{accessor}", resource.build(api_key: api_key, sandbox: sandbox))
      end
    end
  end
end
