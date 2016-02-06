module Enjoy
  if Enjoy.mongoid?
    class Gallery
      include Enjoy::Models::Gallery
      

      rails_admin &Enjoy::Admin::Gallery.config
    end
  end
end
