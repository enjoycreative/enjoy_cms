require 'rails/generators'

module Enjoy::Cms
  class RobotsGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc 'Enjoy CMS robots.txt generator'
    def install
      template('robots.txt.erb', 'public/robots.txt')
    end
  end
end
