module Enjoy
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern
        included do

          field :regexp, type: String, default: ""
          field :redirect, type: String, default: ""
          field :excerpt, type: String, localize: Enjoy.config.localize, default: ""
          field :content, type: String, localize: Enjoy.config.localize, default: ""
          field :fullpath, type: String, default: ""

          has_and_belongs_to_many :menus, inverse_of: :pages, class_name: menu_class_name
          acts_as_nested_set

          manual_slug :name

          scope :sorted, -> { order_by([:lft, :asc]) }
          scope :menu, ->(menu_id) { enabled.sorted.where(menu_ids: menu_id) }
        end
      end
    end
  end
end
