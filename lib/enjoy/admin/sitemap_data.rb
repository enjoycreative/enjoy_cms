module Enjoy
  module Admin
    module SitemapData
      def self.config(is_active = false, fields = {})
        Proc.new {
          navigation_label 'SEO'
          label I18n.t('enjoy.sitemap_data')
          field :sitemap_data_field do
            read_only true
          end
          field :sitemap_show, :toggle
          field :sitemap_lastmod
          field :sitemap_changefreq, :enum do
            enum do
              Enjoy::SitemapData::SITEMAP_CHANGEFREQ_ARRAY
            end
          end
          field :sitemap_priority

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
