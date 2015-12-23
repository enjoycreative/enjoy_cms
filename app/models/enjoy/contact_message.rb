module Enjoy
  if Enjoy.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage
    include Enjoy::Models::ContactMessage
    Enjoy.apply_patches self
    rails_admin &Enjoy.contact_message_config
  end
end
