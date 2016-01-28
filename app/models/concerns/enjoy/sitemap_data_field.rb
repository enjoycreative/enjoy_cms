module Enjoy::SitemapDataField
  extend ActiveSupport::Concern
  FIELDS = [:sitemap_show, :sitemap_lastmod, :sitemap_changefreq, :sitemap_priority]

  included do
    has_one :sitemap_data, as: :sitemap_data_field, autosave: true, class_name: sitemap_data_class_name
    accepts_nested_attributes_for :sitemap_data

    delegate *FIELDS, to: :sitemap_data
    delegate *(FIELDS.map {|f| "#{f}=".to_sym }), to: :sitemap_data

    alias sitemap_data_without_build sitemap_data
    def sitemap_data
      sitemap_data_without_build || build_sitemap_data
    end
  end

  module ClassMethods
    def sitemap_data_class_name
      "Enjoy::SitemapData"
    end

    def sitemap_data_class
      sitemap_data_class_name.constantize
    end
  end

  def sitemap_data_class_name
    self.class.sitemap_data_class_name
  end

  def sitemap_data_class
    self.class.sitemap_data_class
  end
end
