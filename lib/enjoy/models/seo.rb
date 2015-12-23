module Enjoy
  module Models
    module Seo
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Seoable
      
      include Enjoy.orm_specific('Seo')

      included do

        Enjoy.apply_patches self
        validates_attachment_content_type :og_image, content_type: /\Aimage\/.*\Z/, if: :og_image?
      end

      def og_image_styles
        {thumb: "800x600>"}
      end
    end
  end
end
