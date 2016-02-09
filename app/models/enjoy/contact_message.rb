module Enjoy
  if Enjoy.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage
    include Enjoy::Models::ContactMessage

    include Enjoy::Decorators::ContactMessage

    rails_admin(&Enjoy::Admin::ContactMessage.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
