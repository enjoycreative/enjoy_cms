module Enjoy
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern

        module ClassMethods
          def menu_class_name
            "Enjoy::Menu"
          end

          def menu_class
            menu_class_name.constantize
          end
        end

        included do
          field :name, type: String, localize: Enjoy.config.localize, default: ""

          field :regexp, type: String, default: ""
          field :redirect, type: String, default: ""
          field :excerpt, type: String, localize: Enjoy.config.localize, default: ""
          field :content, type: String, localize: Enjoy.config.localize, default: ""
          field :fullpath, type: String, default: ""

          has_and_belongs_to_many :menus, inverse_of: :pages, class_name: menu_class_name
          acts_as_nested_set

          scope :sorted, -> { order_by([:lft, :asc]) }
          scope :menu, ->(menu_id) { enabled.sorted.where(menu_ids: menu_id) }
        end
      end
    end
  end
end
