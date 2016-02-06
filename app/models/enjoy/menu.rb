module Enjoy
  if Enjoy.active_record?
    class Menu < ActiveRecord::Base
    end
  end

  class Menu
    include Enjoy::Models::Menu

    rails_admin &Enjoy::Admin::Menu.config
  end
end
