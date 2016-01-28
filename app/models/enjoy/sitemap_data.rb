module Enjoy
  if Enjoy.active_record?
    class SitemapData < ActiveRecord::Base
    end
  end

  class SitemapData
    include Enjoy::Models::SitemapData
    Enjoy.apply_patches self
    rails_admin &Enjoy.sitemap_data_config
    belongs_to :sitemap_data_field, polymorphic: true
  end
end
