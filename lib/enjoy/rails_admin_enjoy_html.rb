module RailsAdmin
  module Config
    module Fields
      module Types
        class EnjoyHtml < RailsAdmin::Config::Fields::Types::CKEditor
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :html_method do
            "#{name}_html"
          end

          register_instance_option :clear_method do
            "#{name}_clear"
          end

          register_instance_option :pretty_value do
            bindings[:object].send(html_method)
          end

          register_instance_option :form_value do
            {
              html: bindings[:object].send(html_method),
              clear: bindings[:object].send(clear_method)
            }
          end


          register_instance_option :formatted_value do
            pretty_value
          end

          register_instance_option :export_value do
            pretty_value
          end
          

          register_instance_option :boolean_view_helper do
            :check_box
          end

          register_instance_option :allowed_methods do
            [html_method, clear_method]
          end

          register_instance_option :partial do
            :enjoy_html
          end
        end
      end
    end
  end
end
