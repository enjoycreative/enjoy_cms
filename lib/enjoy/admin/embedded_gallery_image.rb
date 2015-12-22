module Enjoy
  module Admin
    module EmbeddedGalleryImage
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Sortable
      include Enjoy.orm_specific('EmbeddedGalleryImage')

      included do
        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end
    end
  end
end