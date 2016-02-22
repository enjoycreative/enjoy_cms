module Enjoy
  module Models
    module Mongoid
      module PageBlockset
        extend ActiveSupport::Concern

        included do
          field :name, type: String, default: ""

          has_and_belongs_to_many :blocks, inverse_of: :blocksets, class_name: "Enjoy::PageBlock"

          scope :sorted, -> { order_by([:lft, :asc]) }
          scope :blockset, ->(block_id) { enabled.sorted.where(block_ids: block_id) }
        end
      end
    end
  end
end
