module Bitex
  module Resources
    module Compliance
      class ArgentinaInvoicingDetailSeed < Seed
        # POST /api/argentina_invoicing_detail_seed
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] address.
        #   @param [String] country.
        #   @param [String] full_name.
        #   @param [String] receipt_kind_code.
        #   @param [String] tax_id.
        #   @param [String] tax_id_kind_code.
        #   @param [String] vat_status_code.
        #
        # @return [NoteSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
