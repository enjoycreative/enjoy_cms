module Enjoy
  if Enjoy.active_record?
    class Page < ActiveRecord::Base
    end
  end

  class Page
    include Enjoy::Models::Page

    include Enjoy::Decorators::Page

    rails_admin(&Enjoy::Admin::Page.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
