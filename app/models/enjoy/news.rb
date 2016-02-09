module Enjoy
  if Enjoy.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include Enjoy::Models::News

    include Enjoy::Decorators::News

    rails_admin(&Enjoy::Admin::News.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
