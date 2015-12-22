module RocketCms
  if RocketCms.active_record?
    class ContactMessage < ActiveRecord::Base
    end
  end

  class ContactMessage
    include RocketCms::Models::ContactMessage
    RocketCms.apply_patches self
    rails_admin &RocketCms.contact_message_config
  end
end
