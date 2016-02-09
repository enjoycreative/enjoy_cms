module Enjoy
  module Admin
    module Menu
      def self.config(fields = {})
        Proc.new {
          # navigation_label 'CMS'

          field :enabled, :toggle
          field :text_slug
          field :name

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
