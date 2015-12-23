module Enjoy::Enableable
  extend ActiveSupport::Concern
  include Enjoy::BooleanField

  included do
    boolean_field(:enabled)
  end
end
