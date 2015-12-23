module Enjoy
  if Enjoy.mongoid?
    class GalleryImage
      include Enjoy::Models::GalleryImage
      Enjoy.apply_patches self

      rails_admin &Enjoy.image_config
    end
  end
end
