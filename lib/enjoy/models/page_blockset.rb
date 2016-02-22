module Enjoy
  module Models
    module PageBlockset
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable

      include Enjoy.orm_specific('PageBlockset')

      included do
      end
    end
  end
end
