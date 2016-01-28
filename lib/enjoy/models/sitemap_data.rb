module Enjoy
  module Models
    module SitemapData
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      include Enjoy.orm_specific('SitemapData')

      SITEMAP_CHANGEFREQ_ARRAY = %w(always hourly daily weekly monthly yearly never)
    end
  end
end
