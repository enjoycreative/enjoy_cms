module Enjoy
  if Enjoy.mongoid?
    class Gallery
      include Enjoy::Models::Gallery

      include Enjoy::Decorators::Gallery

      rails_admin(&Enjoy::Admin::Gallery.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
