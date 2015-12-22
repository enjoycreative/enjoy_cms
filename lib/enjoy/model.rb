module Enjoy
  module Model
    extend ActiveSupport::Concern
    included do
      if Enjoy.mongoid?
        include Mongoid::Document
        include Mongoid::Timestamps::Short
      end
      include ActiveModel::ForbiddenAttributesProtection
      include BooleanField
      include SortField

      if Enjoy.mongoid?
        include Mongoid::Paperclip
      end

      include SmartExcerpt
      include SimpleCaptcha::ModelHelpers

      if Enjoy.mongoid? && defined?(Trackable)
        include Trackable
      end
    end
  end
end
