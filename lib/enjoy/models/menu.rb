module Enjoy
  module Models
    module Menu
      extend ActiveSupport::Concern
      include Enjoy::Model
      include ManualSlug
      include Enjoy::Enableable

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
      end
    end
  end
end
