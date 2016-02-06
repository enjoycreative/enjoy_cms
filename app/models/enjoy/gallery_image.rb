module Enjoy
  if Enjoy.mongoid?
    class GalleryImage
      include Enjoy::Models::GalleryImage
      

      rails_admin &Enjoy::Admin::GalleryImage.config
    end
  end
end
