unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord and not enjoy directly"
  exit 1
end

require 'enjoy/version'
require 'enjoy/configuration'
require 'devise'
require 'enjoy/routes'

require 'simple_form'
require 'enjoy/simple_form_patch'

require 'geocoder'

require 'simple_captcha'
# require 'validates_email_format_of'
require 'filename_to_slug'

require 'rails_admin'
require 'enjoy/rails_admin_ext/config'

require 'enjoy/rails_admin_ext/enjoy_hash'
require 'enjoy/rails_admin_ext/enjoy_html'
require 'enjoy/rails_admin_ext/enjoy_slugs'
require 'enjoy/rails_admin_ext/group_patch'

require 'rails_admin_nested_set'
require 'rails_admin_toggleable'

require 'rails_admin_settings'
require 'enjoy/rails_admin_settings_patch'

# require 'x-real-ip'

require 'ckeditor'

# require 'kaminari'
# require 'addressable/uri'
require 'turbolinks'

require 'enjoy/model'
require 'enjoy/engine'
require 'enjoy/controller'


module Enjoy
  class << self
    def mongoid?
      Enjoy.orm == :mongoid
    end
    def active_record?
      Enjoy.orm == :active_record
    end
    def model_namespace
      "Enjoy::Models::#{Enjoy.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end

    def clear_history_from_empty_objects
      ::HistoryTracker.all.map do |h|
        begin
          begin
            h.delete if h.trackable.nil?
          rescue
            h.delete
          end
        rescue
        end
      end
    end

  end

  autoload :Migration, 'enjoy/migration'

  autoload :Admin,  'enjoy/admin'
  module Admin
    autoload :EmbeddedElement,      'enjoy/admin/embedded_element'
  end

  module Models
    autoload :EmbeddedElement,      'enjoy/models/embedded_element'

    module Mongoid
      autoload :EmbeddedElement,      'enjoy/models/mongoid/embedded_element'
    end
    
    module ActiveRecord
    end
  end

  module Controllers
  end
end

require 'manual_slug'
