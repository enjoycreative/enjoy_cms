module Enjoy
  module Admin
    module PageBlockset
      def self.config(fields = {})
        Proc.new {
          # navigation_label 'CMS'

          field :enabled, :toggle
          field :name


          field :blocks

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

          # field :blocks do
          #   read_only true
          #   help 'Список блоков'
          #
          #   pretty_value do
          #     bindings[:object].blocks.to_a.map { |b|
          #       route = (bindings[:view] || bindings[:controller])
          #       model_name = b.rails_admin_model
          #       route.link_to(b.name, route.rails_admin.show_path(model_name: model_name, id: b.id), title: b.name)
          #     }.join("<br>").html_safe
          #   end
          # end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
