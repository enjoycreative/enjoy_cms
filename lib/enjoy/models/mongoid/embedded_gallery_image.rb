module Enjoy
  module Models
    module Mongoid
      module EmbeddedGalleryImage
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip
        include Enjoy::EmbeddedElement

        included do

          enjoy_mongoid_attached_file(:image,
                    styles: image_styles,
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )
        end
      end
    end
  end
end
