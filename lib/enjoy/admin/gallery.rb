module Enjoy
  module Admin
    module Gallery
      def self.config(fields = {})
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

          fields.each_pair do |name, type|
            if type.nil?
              field name
            else
              if type.is_a?(Array)
                field name, type[0], &type[1]
              else
                field name, type
              end
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
