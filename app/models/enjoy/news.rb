module Enjoy
  if Enjoy.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include Enjoy::Models::News
    Enjoy.apply_patches self
    rails_admin &Enjoy.news_config
  end
end
