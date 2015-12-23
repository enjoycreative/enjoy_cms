module Enjoy
  module Models
    module EmbeddedElement
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Sortable
      
      include Enjoy.orm_specific('EmbeddedElement')
    end
  end
end
