module Enjoy
  if Enjoy.mongoid?
    class PageBlockset
      include Enjoy::Models::PageBlockset

      include Enjoy::Decorators::PageBlockset

      rails_admin(&Enjoy::Admin::PageBlockset.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
