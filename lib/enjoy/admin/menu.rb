module Enjoy
  module Admin
    module Menu
      def self.config(fields = {})
        Proc.new {
          # navigation_label 'CMS'

          field :enabled, :toggle
          field :text_slug
          field :name

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
