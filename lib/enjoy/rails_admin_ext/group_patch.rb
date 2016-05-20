module Enjoy::RailsAdminGroupPatch
  class << self
    def enjoy_cms_group(config, fields = {})
      return unless fields

      if fields.is_a?(Array)
        fields.each do |_group|
          config.group _group[:name] do
            active (_group[:active] || false)
            _group[:fields].each_pair do |name, type|
              if type.blank?
                field name
              else
                if type.is_a?(Array)
                  field name, type[0], &type[1]
                else
                  field name, type
                end
              end
            end
          end
        end

      else
        fields.each_pair do |name, type|
          if type.nil?
            config.field name
          else
            if type.is_a?(Array)
              config.field name, type[0], &type[1]
            else
              config.field name, type
            end
          end
        end
      end
    end
  end
end
