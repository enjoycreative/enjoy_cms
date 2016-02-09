module Enjoy
  if Enjoy.active_record?
    class SitemapData < ActiveRecord::Base
    end
  end

  class SitemapData
    include Enjoy::Models::SitemapData

    include Enjoy::Decorators::SitemapData

    rails_admin(&Enjoy::Admin::SitemapData.config(false, rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
