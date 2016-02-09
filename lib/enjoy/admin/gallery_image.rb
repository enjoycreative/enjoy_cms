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
          
          fields.each_pair do |name, type|
            if type.nil?
              field name
            else
              field name, type
            end
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
