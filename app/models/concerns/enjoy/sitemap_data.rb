module Enjoy::SitemapData
  extend ActiveSupport::Concern

  SITEMAP_CHANGEFREQ_ARRAY = %w(always hourly daily weekly monthly yearly never)

  included do
    if Enjoy.mongoid?
      field :sitemap_show,        type: Boolean, default: true
      field :sitemap_lastmod,     type: DateTime
      field :sitemap_changefreq,  type: String,   default: 'daily'
      field :sitemap_priority,    type: Float

      scope :sitemap_show,    -> { where(sitemap_show: true) }
      scope :for_sitemap,     -> { sitemap_show }
      scope :show_in_sitemap, -> { sitemap_show }
    elsif Enjoy.active_record?
    end
  end

  def self.admin
    Enjoy.sitemap_data_config
  end
end
