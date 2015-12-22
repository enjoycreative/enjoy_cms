module RocketCms
  if RocketCms.active_record?
    class Page < ActiveRecord::Base
    end
  end

  class Page
    include RocketCms::Models::Page
    RocketCms.apply_patches self
    rails_admin &RocketCms.page_config
  end
end
