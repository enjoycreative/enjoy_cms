module Enjoy
  module Models
    module Mongoid
      module GalleryImage
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip

        included do
          if defined?(RailsAdminComments)
            include RailsAdminComments::Commentable
          end


          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_mongoid_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles },
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )
        end

        def image_styles
          {}
        end
      end
    end
  end
end
