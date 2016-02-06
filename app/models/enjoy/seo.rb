module Enjoy
  if Enjoy.active_record?
    class Seo < ActiveRecord::Base
    end
  end

  class Seo
    include Enjoy::Models::Seo
    
    rails_admin &Enjoy::Admin::Seo.config
  end
end
