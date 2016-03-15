if Enjoy.mongoid?
  module Enjoy::HtmlField
    extend ActiveSupport::Concern

    module ClassMethods
      def enjoy_cms_html_field(name, opts = {})
        clear_by_default = opts.delete(:clear_by_default)
        clear_by_default = false unless clear_by_default == true

        field "#{name}_html", opts
        field "#{name}_clear", type: Boolean, default: clear_by_default, localize: opts[:localize]

        class_eval <<-EVAL
          def #{name}
            self.#{name}_html ||= ""
            return self.#{name}_html unless self.#{name}_clear
            Rails::Html::FullSanitizer.new.sanitize(self.#{name}_html.strip)
          end
        EVAL
      end
    end
  end
end
