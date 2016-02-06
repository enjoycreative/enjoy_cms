module Enjoy
  module Admin
    module Gallery
      def self.self.config
        Proc.new {
          # navigation_label I18n.t('enjoy.gallery')
          field :enabled, :toggle

          field :name, :string
          field :slugs, :enum do
            enum_method do
              :slugs
            end
            visible do
              bindings[:view].current_user.admin?
            end
            multiple do
              true
            end
          end
          field :text_slug

          field :image, :jcrop do
            jcrop_options :image_jcrop_options
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
