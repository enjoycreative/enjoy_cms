module Enjoy
  if Enjoy.mongoid?
    class GalleryImage
      include Enjoy::Models::GalleryImage

      include Enjoy::Decorators::GalleryImage

      rails_admin(&Enjoy::Admin::GalleryImage.config(rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
