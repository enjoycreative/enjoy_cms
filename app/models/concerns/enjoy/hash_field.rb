if Enjoy.mongoid?
  module Enjoy::HashField
    extend ActiveSupport::Concern

    module ClassMethods
      def enjoy_cms_hash_field(name, opts = {})
        field "#{name}_hash", opts

        class_eval <<-EVAL
          def #{name}_str=(val)
            begin
              self.#{name}_hash = JSON.parse(val)
            rescue
              self[:#{name}_str] = val
            end
          end
          def #{name}_str
            self[:#{name}_str] ||= self.#{name}.to_json
          end
          def #{name}
            self.#{name}_hash
          end

          validate do
            if self.#{name}_str != self.#{name}.to_json
              self.errors.add(:#{name}, "Неверный формат данных")
            else
              self.remove_attribute :#{name}_str
            end
            true
          end
        EVAL
      end
    end
  end
end
