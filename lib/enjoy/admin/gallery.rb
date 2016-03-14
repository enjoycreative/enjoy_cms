module Enjoy
  module Admin
    module Gallery
      def self.config(fields = {})
        Proc.new {
          # navigation_label I18n.t('enjoy.gallery')
          field :enabled, :toggle do
            searchable false
          end

          field :name, :string do
            searchable true
          end
          group :URL do
            active false
            searchable true
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
          end

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
