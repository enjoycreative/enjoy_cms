module Enjoy
  module Models
    module ActiveRecord
      module Menu
        extend ActiveSupport::Concern
        included do
          has_paper_trail
          validates_lengths_from_database
          if Enjoy.config.localize
            translates :name
          end
        end
      end
    end
  end
end

