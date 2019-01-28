module Bitex
  module Resources
    module Compliance
      class NoteSeed < Seed
        # POST /api/note_seeds
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] body.
        #   @param [String] title.
        #
        # @return [NoteSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
