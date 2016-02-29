module Enjoy
  module Models
    module Mongoid
      module SitemapData
        extend ActiveSupport::Concern

        included do

          if defined?(RailsAdminComments)
            include RailsAdminComments::Commentable
          end

          field :sitemap_show,        type: Boolean, default: true
          field :sitemap_lastmod,     type: DateTime
          field :sitemap_changefreq,  type: String,   default: 'daily'
          field :sitemap_priority,    type: Float

          scope :sitemap_show,    -> { where(sitemap_show: true) }
          scope :for_sitemap,     -> { sitemap_show }
          scope :show_in_sitemap, -> { sitemap_show }
        end
      end
    end
  end
end
