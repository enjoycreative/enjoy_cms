unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord and not enjoy directly"
  exit 1
end

require 'enjoy/version'
require 'devise'

require 'simple_form'
require 'enjoy/simple_form_patch'

require 'glebtv-simple_captcha'
require 'validates_email_format_of'
require 'smart_excerpt'
require 'filename_to_slug'
require 'rails_admin'
require 'rails_admin_nested_set'
require 'rails_admin_toggleable'
# require 'rails_admin_settings'

require 'x-real-ip'

require 'ckeditor'

require 'sitemap_generator'
require 'kaminari'
require 'addressable/uri'
require 'turbolinks'
require 'simple-navigation'
require 'ack_rails_admin_jcrop'

require 'paperclip-optimizer'

require 'enjoy/configuration'
require 'enjoy/elastic_search'
require 'enjoy/model'
require 'enjoy/rails_admin_menu'
require 'enjoy/rails_admin_enjoy_html'
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
  end

  autoload :Migration, 'enjoy/migration'

  # module Mongoid
  #   autoload :Paperclip  'enjoy/mongoid/paperlcip'
  # end

  autoload :Admin,  'enjoy/admin'
  module Admin
    autoload :SitemapData,  'enjoy/admin/sitemap_data'
    autoload :Seo,  'enjoy/admin/seo'
    autoload :Menu, 'enjoy/admin/menu'
    autoload :Page, 'enjoy/admin/page'
    autoload :News, 'enjoy/admin/news'
    autoload :ContactMessage, 'enjoy/admin/contact_message'

    autoload :EmbeddedElement,      'enjoy/admin/embedded_element'

    autoload :EmbeddedGalleryImage, 'enjoy/admin/embedded_gallery_image'
    autoload :GalleryImage,         'enjoy/admin/gallery_image'
    autoload :Gallery,              'enjoy/admin/gallery'
  end

  module Models
    autoload :SitemapData,  'enjoy/models/sitemap_data'
    autoload :Seo,  'enjoy/models/seo'
    autoload :Menu, 'enjoy/models/menu'
    autoload :Page, 'enjoy/models/page'
    autoload :News, 'enjoy/models/news'
    autoload :ContactMessage, 'enjoy/models/contact_message'

    autoload :EmbeddedElement,      'enjoy/models/embedded_element'

    autoload :EmbeddedGalleryImage, 'enjoy/models/embedded_gallery_image'
    autoload :GalleryImage,         'enjoy/models/gallery_image'
    autoload :Gallery,              'enjoy/models/gallery'

    module Mongoid
      autoload :SitemapData,  'enjoy/models/mongoid/sitemap_data'
      autoload :Seo,  'enjoy/models/mongoid/seo'
      autoload :Menu, 'enjoy/models/mongoid/menu'
      autoload :Page, 'enjoy/models/mongoid/page'
      autoload :News, 'enjoy/models/mongoid/news'
      autoload :ContactMessage, 'enjoy/models/mongoid/contact_message'

      autoload :EmbeddedElement,      'enjoy/models/mongoid/embedded_element'

      autoload :EmbeddedGalleryImage, 'enjoy/models/mongoid/embedded_gallery_image'
      autoload :GalleryImage,         'enjoy/models/mongoid/gallery_image'
      autoload :Gallery,              'enjoy/models/mongoid/gallery'
    end

    module ActiveRecord
      autoload :SitemapData,  'enjoy/models/active_record/sitemap_data'
      autoload :Seo,  'enjoy/models/active_record/seo'
      autoload :Menu, 'enjoy/models/active_record/menu'
      autoload :Page, 'enjoy/models/active_record/page'
      autoload :News, 'enjoy/models/active_record/news'
      autoload :ContactMessage, 'enjoy/models/active_record/contact_message'
    end
  end

  module Controllers
    autoload :Contacts, 'enjoy/controllers/contacts'
    autoload :News, 'enjoy/controllers/news'
    autoload :Pages, 'enjoy/controllers/pages'
    autoload :Search, 'enjoy/controllers/search'
  end
end

require 'manual_slug'
