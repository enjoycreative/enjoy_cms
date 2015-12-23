module Enjoy::Sortable
  extend ActiveSupport::Concern
  include Enjoy::SortField

  included do
    sort_field
  end
end
