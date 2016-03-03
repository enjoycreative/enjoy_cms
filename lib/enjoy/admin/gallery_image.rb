module Enjoy
  module Admin
    module GalleryImage
      def self.config(without_gallery = false, fields = {})
        Proc.new {
          # navigation_label I18n.t('enjoy.gallery')
          field :enabled, :toggle
          unless without_gallery
            field :gallery
          end
          field :name, :string
          field :image, :jcrop do
            jcrop_options :image_jcrop_options
          end

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
