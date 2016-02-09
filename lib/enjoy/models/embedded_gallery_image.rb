module Enjoy
  module Models
    module EmbeddedGalleryImage
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Sortable

      include Enjoy.orm_specific('EmbeddedGalleryImage')

      included do
        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end

      module ClassMethods
        def rails_admin_add_fields
          {}
        end

        def rails_admin_add_config(config)
        end
      end
    end
  end
end
