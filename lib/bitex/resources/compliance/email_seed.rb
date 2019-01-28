module Bitex
  module Resources
    module Compliance
      class EmailSeed < Seed 
        # POST /api/email_seeds
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] address.
        #   @param [String] email_kind_code.
        #
        # @return [EmailSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
