module SortField
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_field(prefix = '')
      prefix = "#{prefix}_" unless prefix == ''

      if RocketCms.mongoid?
        field "#{prefix}order".to_sym, type: Integer
        alias_method "#{prefix}sort", "#{prefix}order"
        scope "#{prefix}ordered".to_sym,  -> { asc("#{prefix}order".to_sym) }
        scope "#{prefix}sorted".to_sym,   -> { asc("#{prefix}order".to_sym) }
      end
      if RocketCms.active_record?
        scope "#{prefix}ordered".to_sym,  -> { order("#{prefix}order".to_sym => :asc) }
        scope "#{prefix}sorted".to_sym,   -> { order("#{prefix}order".to_sym => :asc) }
      end
    end
  end
end
