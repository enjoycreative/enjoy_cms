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

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
