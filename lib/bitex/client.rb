module Bitex
  # This client connects via API to Bitex resources.
  class Client
    attr_reader :api_key

    def initialize(api_key: nil, sandbox: false)
      @api_key = api_key
      setup_environment(sandbox)
    end

    def setup_environment(sandbox)
      Base.site = "https://#{'sandbox.' if sandbox}bitex.la/api/"
    end

    def accounts
      @accounts ||= Forwarder.new(Account, api_key)
    end

    def api_keys
      @api_keys ||= Forwarder.new(ApiKey, api_key)
    end

    def asks
      @asks ||= Forwarder.new(Ask, api_key)
    end

    def asset_wallets
      @asset_wallets ||= Forwarder.new(AssetWallet, api_key)
    end

    def bids
      @bids ||= Forwarder.new(Bid, api_key)
    end

    def buying_bots
      @buying_bots = Forwarder.new(BuyingBot, api_key)
    end

    def cash_withdrawals
      @cash_withdrawals ||= Forwarder.new(CashWithdrawal, api_key)
    end

    def coin_withdrawals
      @coin_withdrawals ||= Forwarder.new(CoinWithdrawal, api_key)
    end

    def markets
      @markets ||= Forwarder.new(Market)
    end

    def selling_bots
      @selling_bots ||= Forwarder.new(SellingBot, api_key)
    end

    def withdrawal_instructions
      @withdrawal_instructions ||= Forwarder.new(WithdrawalInstruction, api_key)
    end

    # Compliance

    def allowance_seeds
      @allowance_seeds = Forwarder.new(Compliance::AllowanceSeed, api_key)
    end

    def argentina_invoicing_detail_seeds
      @argentina_invoicing_detail_seeds ||= Forwarder.new(Compliance::ArgentinaInvoicingDetailSeed, api_key)
    end

    def chile_invoicing_detail_seeds
      @chile_invoicing_detail_seeds ||= Forwarder.new(Compliance::ChileInvoicingDetailSeed, api_key)
    end

    def domicile_seeds
      @domicile_seeds ||= Forwarder.new(Compliance::DomicileSeed, api_key)
    end

    def email_seeds
      @email_seeds ||= Forwarder.new(Compliance::EmailSeed, api_key)
    end

    def identification_seeds
      @identification_seeds ||= Forwarder.new(Compliance::IdentificationSeed, api_key)
    end
  end
end
