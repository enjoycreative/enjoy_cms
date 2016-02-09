module Enjoy
  if Enjoy.active_record?
    class Menu < ActiveRecord::Base
    end
  end

  class Menu
    include Enjoy::Models::Menu

    include Enjoy::Decorators::Menu

    rails_admin(&Enjoy::Admin::Menu.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
