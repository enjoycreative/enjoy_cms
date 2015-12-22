module Enjoy
  module Models
    module Menu
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include ManualSlug
      include Enjoy.orm_specific('Menu')

      included do

        field :name, type: String
        manual_slug :name

        after_save do
          Rails.cache.delete 'menus'
        end
        after_destroy do
          Rails.cache.delete 'menus'
        end

        has_and_belongs_to_many :pages, inverse_of: :menus, class_name: "Enjoy::Page"
        alias_method :items, :pages
      end
    end
  end
end
