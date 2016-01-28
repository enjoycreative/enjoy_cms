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
    end
  end
end
