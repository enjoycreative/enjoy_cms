module Enjoy
  if Enjoy.active_record?
    class Menu < ActiveRecord::Base
    end
  end

  class Menu
    include Enjoy::Models::Menu
    Enjoy.apply_patches self
    rails_admin &Enjoy.menu_config
  end
end
