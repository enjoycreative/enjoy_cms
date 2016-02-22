module Enjoy
  module Models
    module PageBlock
      extend ActiveSupport::Concern

      include Enjoy.orm_specific('PageBlock')

      included do
      end
    end
  end
end
