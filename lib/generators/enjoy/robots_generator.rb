require 'rails/generators'

module Enjoy
  class RobotsGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc 'Enjoy robots.txt generator'
    def install
      template('robots.txt.erb', 'public/robots.txt')
    end
  end
end
