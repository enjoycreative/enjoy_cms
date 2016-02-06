module Enjoy
  if Enjoy.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage
    include Enjoy::Models::ContactMessage
    
    rails_admin &Enjoy::Admin::ContactMessage.config
  end
end
