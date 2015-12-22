module Enjoy
  module Admin
    module Gallery
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include ManualSlug
      include SitemapData
      include Enjoy.orm_specific('Gallery')

      included do

        has_many :gallery_images, class_name: "Enjoy::GalleryImage"
        field :name, type: String, localize: Enjoy.configuration.localize

        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
      end
    end
  end
end
