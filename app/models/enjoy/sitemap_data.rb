module Enjoy
  if Enjoy.active_record?
    class SitemapData < ActiveRecord::Base
    end
  end

  class SitemapData
    include Enjoy::Models::SitemapData
    
    rails_admin &Enjoy::Admin::SitemapData.config
  end
end
