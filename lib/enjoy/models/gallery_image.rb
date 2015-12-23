module Enjoy
  module Models
    module GalleryImage
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      
      include Enjoy.orm_specific('GalleryImage')

      included do

        belongs_to :gallery, class_name: gallery_class_name
        field :name, type: String, localize: Enjoy.configuration.localize

        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end

      def gallery_class_name
        "Enjoy::Gallery"
      end
    end
  end
end
