module Enjoy
  module Model
    extend ActiveSupport::Concern
    included do
      if Enjoy.mongoid?
        include Mongoid::Document
        include Mongoid::Timestamps::Short

        if Enjoy.config.localize
          include Enjoy::ModelLocalizeable
        end
      end

      include ActiveModel::ForbiddenAttributesProtection
      include Enjoy::BooleanField
      include Enjoy::SortField

      include SmartExcerpt
      include SimpleCaptcha::ModelHelpers

      if Enjoy.mongoid? && defined?(Trackable)
        include Trackable
      end

      include Enjoy::RailsAdminPatch
    end
  end
end
