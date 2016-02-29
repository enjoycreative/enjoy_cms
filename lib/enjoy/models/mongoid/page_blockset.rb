module Enjoy
  module Models
    module Mongoid
      module PageBlockset
        extend ActiveSupport::Concern

        included do
          if defined?(RailsAdminComments)
            include RailsAdminComments::Commentable
          end

          field :name, type: String, default: ""

          embeds_many :blocks, inverse_of: :blockset, class_name: "Enjoy::PageBlock"
          accepts_nested_attributes_for :blocks
        end
      end
    end
  end
end
