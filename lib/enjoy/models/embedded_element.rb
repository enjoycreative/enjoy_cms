module Enjoy
  module Models
    module EmbeddedElement
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Sortable

      include Enjoy.orm_specific('EmbeddedElement')

      module ClassMethods
        def rails_admin_add_fields
          {}
        end

        def rails_admin_add_config(config)
        end
      end
    end
  end
end
