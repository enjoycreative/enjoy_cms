module Enjoy
  if Enjoy.mongoid?
    class Gallery
      include Enjoy::Models::Gallery
      Enjoy.apply_patches self

      rails_admin &Enjoy.gallery_config
    end
  end
end
