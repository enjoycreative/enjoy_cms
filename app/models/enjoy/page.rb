module Enjoy
  if Enjoy.active_record?
    class Page < ActiveRecord::Base
    end
  end

  class Page
    include Enjoy::Models::Page

    rails_admin &Enjoy::Admin::Page.config
  end
end
