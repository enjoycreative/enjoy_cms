module Enjoy
  module Models
    module Mongoid
      module Menu
        extend ActiveSupport::Concern
        included do

          field :name, type: String, default: ""
        end
      end
    end
  end
end
