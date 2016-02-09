module Enjoy
  if Enjoy.mongoid?
    class EmbeddedElement
      include Enjoy::Models::EmbeddedElement

      include Enjoy::Decorators::EmbeddedElement


      # use it in inherited model
      # rails_admin &Enjoy::Admin::EmbeddedElement.config

      # use it in rails_admin in parent model for sort
      # sort_embedded({fields: [:embedded_field_1, :embedded_field_2...]})
      # or u need to override rails_admin in inherited model to add sort field
    end
  end
end
