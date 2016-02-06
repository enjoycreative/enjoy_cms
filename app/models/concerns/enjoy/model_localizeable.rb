module Enjoy::ModelLocalizeable
  extend ActiveSupport::Concern

  module ClassMethods
    def convert2localize
      self.all.to_a.map do |p|
        p.convert2localize
      end
    end
  end

  def convert2localize
    arr = {}
    self.localized_fields.keys.each do |f|
      next if self[f].is_a?(Hash)
      arr[f] = self.remove_attribute(f)
      self[f] = {}
    end
    self.save

    I18n.available_locales.each do |l|
      I18n.with_locale(l) do
        arr.each_pair do |f, v|
          self.send(f + "=", v)
        end
      end
    end
    self.save
  end
end
