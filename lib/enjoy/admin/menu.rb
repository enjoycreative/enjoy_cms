module Enjoy
  module Admin
    module Menu
      def self.config
        Proc.new {
          # navigation_label 'CMS'

          field :enabled, :toggle
          field :text_slug
          field :name

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
