module Enjoy
  module Admin
    module ContactMessage
      def self.config(fields = {})
        Proc.new {
          # navigation_label I18n.t('enjoy.contact_message')
          field :c_at do
            read_only true
          end
          field :name
          field :content, :text
          field :email
          field :phone

          Enjoy.config.contacts_fields.each_pair do |fn, ft|
            next if ft.nil?
            if ft.is_a?(Array)
              field fn, ft[1].to_sym
            else
              field fn
            end
          end

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
