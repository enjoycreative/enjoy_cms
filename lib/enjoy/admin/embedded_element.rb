module Enjoy
  module Admin
    module EmbeddedElement
      def self.config(_navigation_label = I18n.t('enjoy.cms'), fields = {})
        Proc.new {
          # navigation_label(_navigation_label) unless _navigation_label.nil?
          field :enabled, :toggle
          field :name, :string

          Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
