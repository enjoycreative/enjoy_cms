module Enjoy
  if Enjoy.mongoid?
    class Enjoy
      include Enjoy::Models::Enjoy
      Enjoy.apply_patches self

      # use it in inherited model
      #rails_admin &Enjoy.embedded_image_config

      # use it in rails_admin in parent model for sort
      # sort_embedded({fields: [:embedded_field_1, :embedded_field_2...]})
      # or u need to override rails_admin in inherited model to add sort field
    end
  end
end
