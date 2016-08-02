require 'rails_admin'
module Enjoy::RailsAdminGroupPatch
  class << self
    def enjoy_cms_group(config, fields = {})
      return unless fields

      if fields.is_a?(Array)
        fields.each do |_group|
          config.group (_group[:name] || :default) do
            active (_group[:active] || false)
            label _group[:label] if _group[:label].present?
            help _group[:help] if _group[:help].present?
            weight _group[:weight] if _group[:weight].present?
            (_group[:fields] || {}).each_pair do |name, type|
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
