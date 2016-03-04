require 'rails_admin/config/fields/types/has_many_association'

module RailsAdmin
  module Config
    module Fields
      module Types
        class EnjoyConnectable < RailsAdmin::Config::Fields::Types::HasManyAssociation
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :partial do
            :enjoy_connectable
          end

          register_instance_option :autocreate_page_attr do
            :enjoy_connectable_autocreate_page
          end

          register_instance_option :allowed_methods do
            [method_name, autocreate_page_attr]
          end

          register_instance_option :associated_collection_scope do
            me = bindings[:object]
            Proc.new do |scope|
              scope.unconnected(me).enabled.sorted
            end
          end
        end
      end
    end
  end
end
