require 'rails/generators'

module Enjoy::Cms
  class GemfileGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy CMS Gemfile generator'
    def install
      template 'Gemfile.erb', "Gemfile"
    end

  end
end
