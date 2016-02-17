module Enjoy
  module Models
    module Mongoid
      module GalleryImage
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip

        included do

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_mongoid_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles },
                    convert_options: lambda { |attachment| attachment.instance.image_convert_options },
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )
        end

        def image_styles
          {}
        end
        def image_convert_options
          {}
        end
      end
    end
  end
end
