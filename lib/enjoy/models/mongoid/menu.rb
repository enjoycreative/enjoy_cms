module Enjoy
  module Models
    module Mongoid
      module Menu
        extend ActiveSupport::Concern

        module ClassMethods
          def page_class_name
            "Enjoy::Page"
          end

          def page_class
            page_class_name.constantize
          end
        end
        
        included do
          has_and_belongs_to_many :pages, inverse_of: :menus, class_name: page_class_name
          alias_method :items, :pages

          field :name, type: String, default: ""
        end
      end
    end
  end
end
