module RocketCms
  if RocketCms.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include RocketCms::Models::News
    RocketCms.apply_patches self
    rails_admin &RocketCms.news_config
  end
end
