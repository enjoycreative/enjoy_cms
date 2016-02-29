module Enjoy
  module Models
    module PageBlockset
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include ManualSlug

      include Enjoy.orm_specific('PageBlockset')

      included do
        manual_slug :name

        # after_save do
        #   Rails.cache.delete 'blocksets'
        # end
        # after_destroy do
        #   Rails.cache.delete 'blocksets'
        # end
      end

    end
  end
end
