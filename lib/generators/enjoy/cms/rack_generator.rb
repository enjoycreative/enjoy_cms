require 'rails/generators'

module Enjoy::Cms
  class RackGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc 'Enjoy CMS Rack generator'
    def install
      template('rack.erb', 'config/initializers/rack.rb')
    end
  end
end
