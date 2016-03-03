module Enjoy
  module Admin
    module Seo
      def self.config(is_active = true, fields = {})
        Proc.new {
          navigation_label 'SEO'
          field :seoable do
            read_only true
          end
          field :h1, :string
          field :title, :string
          field :keywords, :text
          field :description, :text
          field :robots, :string

          field :og_title, :string

          field :og_image, :jcrop do
            jcrop_options :og_image_jcrop_options
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
