module Enjoy
  module Models
    module SitemapData
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      include Enjoy.orm_specific('SitemapData')

      SITEMAP_CHANGEFREQ_ARRAY = %w(always hourly daily weekly monthly yearly never)

      included do
        belongs_to :sitemap_data_field, polymorphic: true
      end
    end
  end
end
