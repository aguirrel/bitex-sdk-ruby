module Bitex
  module Resources
    module Compliance
      class PhoneSeed < Seed
        # POST /api/phone_seed
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] country.
        #   @param [String] number.
        #   @param [String] phone_kind_code.
        #   @param [String] has_telegram.
        #   @param [String] has_whatsapp.
        #   @param [String] note.
        #
        # @return [PhoneSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
