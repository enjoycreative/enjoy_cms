module Enjoy
  module Models
    module Seo
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Enjoy.orm_specific('Seo')
      include Enjoy::SeoHelpers

      included do

        Enjoy.apply_patches self
        validates_attachment_content_type :og_image, content_type: /\Aimage\/.*\Z/, if: :og_image?
      end
    end
  end
end
