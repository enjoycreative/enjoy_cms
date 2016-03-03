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
        end
      end
    end
  end
end
