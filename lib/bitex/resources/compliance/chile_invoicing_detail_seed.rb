module Bitex
  module Resources
    module Compliance
      class ChileInvoicingDetailSeed < Seed
        # POST /api/chile_invoicing_detail_seed
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] ciudad.
        #   @param [String] comuna.
        #   @param [String] giro.
        #   @param [String] tax_id.
        #   @param [String] vat_status_code.
        #
        # @return [ChileInvoicingDetailSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
