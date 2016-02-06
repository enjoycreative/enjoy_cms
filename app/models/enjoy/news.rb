module Enjoy
  if Enjoy.active_record?
    class News < ActiveRecord::Base
    end
  end

  class News
    include Enjoy::Models::News

    rails_admin &Enjoy::Admin::News.config
  end
end
