module Enjoy
  module Admin
    module EmbeddedElement
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Sortable
      include Enjoy.orm_specific('EmbeddedElement')
    end
  end
end