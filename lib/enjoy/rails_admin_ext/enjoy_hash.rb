require 'rails_admin/config/fields/types/text'
require 'json'

module RailsAdmin
  module Config
    module Fields
      module Types
        class EnjoyHash < RailsAdmin::Config::Fields::Types::Text
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :string_method do
            "#{name}_str"
          end

          register_instance_option :allowed_methods do
            [string_method]
          end

          register_instance_option :partial do
            :enjoy_hash
          end

          register_instance_option :formatted_value do
            begin
              JSON.pretty_generate(JSON.parse(bindings[:object].send string_method))
            rescue
              bindings[:object].send string_method
            end
          end

          register_instance_option :pretty_value do
            ("<pre>" + JSON.pretty_generate(value) + "</pre>").html_safe
          end
        end
      end
    end
  end
end
