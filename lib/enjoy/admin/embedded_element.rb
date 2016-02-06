module Enjoy
  module Admin
    module EmbeddedElement
      def self.config(_navigation_label = I18n.t('enjoy.cms'), fields = {})
        Proc.new {
          # navigation_label(_navigation_label) unless _navigation_label.nil?
          field :enabled, :toggle
          field :name, :string
          fields.each_pair do |name, type|
            if type.nil?
              field name
            else
              if type.is_a?(Array)
                field name, type[0], &type[1]
              else
                field name, type
              end
            end
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
