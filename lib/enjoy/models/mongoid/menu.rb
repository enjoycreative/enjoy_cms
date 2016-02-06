module Enjoy
  module Models
    module Mongoid
      module Menu
        extend ActiveSupport::Concern

        included do
          has_and_belongs_to_many :pages, inverse_of: :menus, class_name: "Enjoy::Page"
          alias_method :items, :pages

          field :name, type: String, default: ""
        end
      end
    end
  end
end
