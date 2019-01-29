module Bitex
  module Resources
    module Compliance
      # This resource allows you to link attachments to reinforce orders where necessary.
      class Attachment < Private
        # POST /api/attachments
        #
        # @params [Hash] attrs:
        #   document: ENCODED FILE IN BASE64. eg: data:image/jpeg;base64,/9j/4AAQSkZJR...
        #   document_file_name: eg: [String] 'id_front.jpg'
        #   document_content_type: [String] 'image/jpeg'
        #   document_file_size: [Integer] 8391
        #   seed: [Seed] instance of subclass seed, IdentifactionSeed, DomicileSeed, etc.
        #
        # @return [Attachment]
        def self.create(id, **attrs)
          seed = attrs.delete(:seed)
          new(**attrs).tap do |attachment|
            attachment.relationships.attributes = attach_to(seed)
            authorize_with_user(id) { attachment.save }
          end
        end

        # @param [Seed] seed.
        #
        # @return [Hash] with attachment relationship
        def self.attach_to(seed)
          { attached_to_seed: { data: { id: seed.id, type: seed.type } } }
        end

        private_class_method :attach_to
      end
    end
  end
end
