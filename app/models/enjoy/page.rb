module Enjoy
  if Enjoy.active_record?
    class Page < ActiveRecord::Base
    end
  end

  class Page
    include Enjoy::Models::Page
    Enjoy.apply_patches self
    rails_admin &Enjoy.page_config
  end
end
