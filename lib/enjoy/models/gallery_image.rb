module Enjoy
  module Models
    module GalleryImage
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      module ClassMethods
        def gallery_class_name
          "Enjoy::Gallery"
        end

        def gallery_class
          gallery_class_name.constantize
        end
      end

      include Enjoy.orm_specific('GalleryImage')

      included do

        belongs_to :gallery, class_name: gallery_class_name
        field :name, type: String, localize: Enjoy.configuration.localize

        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end
    end
  end
end
