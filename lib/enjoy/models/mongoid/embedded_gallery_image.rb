module Enjoy
  module Models
    module Mongoid
      module EmbeddedGalleryImage
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip

        included do

          enjoy_cms_mongoid_attached_file(:image,
                    styles: image_styles,
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )
        end

        module ClassMethods
          def image_styles
            {}
          end
        end
      end
    end
  end
end
