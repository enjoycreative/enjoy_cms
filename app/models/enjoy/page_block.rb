module Enjoy
  if Enjoy.mongoid?
    class PageBlock < Enjoy::EmbeddedElement
      include Enjoy::Models::PageBlock

      include Enjoy::Decorators::PageBlock

      rails_admin(&Enjoy::Admin::PageBlock.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
