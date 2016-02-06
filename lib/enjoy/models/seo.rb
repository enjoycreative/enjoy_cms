module Enjoy
  module Models
    module Seo
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      include Enjoy.orm_specific('Seo')

      included do
        belongs_to :seoable, polymorphic: true

        validates_attachment_content_type :og_image, content_type: /\Aimage\/.*\Z/, if: :og_image?
      end
    end
  end
end
