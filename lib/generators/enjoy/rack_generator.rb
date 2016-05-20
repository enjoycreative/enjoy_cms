require 'rails/generators'

module Enjoy
  class RackGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc 'Enjoy Rack generator'
    def install
      template('rack.erb', 'config/initializers/rack.rb')
    end
  end
end
