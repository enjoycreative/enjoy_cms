module Enjoy
  if Enjoy.active_record?
    class Seo < ActiveRecord::Base
    end
  end

  class Seo
    include Enjoy::Models::Seo

    include Enjoy::Decorators::Seo

    rails_admin(&Enjoy::Admin::Seo.config(false, rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
