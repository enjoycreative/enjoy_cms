module Enjoy
  module Models
    module GalleryImage
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Enjoy.orm_specific('GalleryImage')

      included do

        belongs_to :gallery, class_name: "Enjoy::Gallery"
        field :name, type: String, localize: Enjoy.configuration.localize

        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end
    end
  end
end
