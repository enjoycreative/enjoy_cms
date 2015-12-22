module RocketCms
  if RocketCms.active_record?
    class Menu < ActiveRecord::Base
    end
  end

  class Menu
    include RocketCms::Models::Menu
    RocketCms.apply_patches self
    rails_admin &RocketCms.menu_config
  end
end
