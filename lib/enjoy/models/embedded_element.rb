module Enjoy
  module Models
    module EmbeddedElement
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Sortable
      include Enjoy.orm_specific('EmbeddedElement')
    end
  end
end