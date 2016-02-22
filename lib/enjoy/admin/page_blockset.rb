module Enjoy
  module Admin
    module PageBlockset
      def self.config(fields = {})
        Proc.new {
          # navigation_label 'CMS'

          field :enabled, :toggle
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

          field :items do
            read_only true
            help 'Список блоков'

            pretty_value do
              bindings[:object].items.to_a.map { |i|
                route = (bindings[:view] || bindings[:controller])
                model_name = i.rails_admin_model
                route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
              }.join("<br>").html_safe
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
