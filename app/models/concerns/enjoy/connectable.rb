module Enjoy::Connectable
  extend ActiveSupport::Concern

  module ClassMethods
    def enjoy_connectable_field (name = :connected_pages, opts = {})
      class_name = opts.delete(:class_name)
      class_name ||= "Enjoy::Page"
      routes_namespace = opts.delete(:routes_namespace)
      routes_namespace ||= :main_app
      autocreate_page = opts.delete(:autocreate_page)
      autocreate_page = true if autocreate_page.nil?

      has_many name, as: :connectable, class_name: "Enjoy::Page"
      class_eval <<-EVAL
        def routes_namespace
          :#{routes_namespace}
        end
      EVAL

      if autocreate_page
        attr_accessor :enjoy_connectable_autocreate_page
        _name_attr = Enjoy.config.localize ? "name_translations" : "name"
        class_eval <<-EVAL
          after_create do
            if self.enjoy_connectable_autocreate_page
              _p = #{class_name}.new
              _p.#{_name_attr} = self.#{_name_attr}
              _p.connectable = self
              _p.save
            end
          end
        EVAL
      end
    end
  end
end
