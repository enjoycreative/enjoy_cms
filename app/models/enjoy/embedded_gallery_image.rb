module Enjoy
  if Enjoy.mongoid?
    class EmbeddedGalleryImage < Enjoy::EmbeddedElement
      include Enjoy::Models::EmbeddedGalleryImage
      

      # use it in inherited model
      # rails_admin &Enjoy::Admin::EmbeddedGalleryImage.config

      # use it in rails_admin in parent model for sort
      # sort_embedded({fields: [:embedded_field_1, :embedded_field_2...]})
      # or u need to override rails_admin in inherited model to add sort field
    end
  end
end
