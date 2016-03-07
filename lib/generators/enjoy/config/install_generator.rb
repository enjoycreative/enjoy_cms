require 'rails/generators'

module Enjoy::Config
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::CMS Config generator'
    def install
      template 'enjoy_cms.erb', "config/initializers/enjoy_cms.rb"
    end

  end
end
