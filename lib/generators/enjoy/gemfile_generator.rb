require 'rails/generators'

module Enjoy
  class GemfileGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy Gemfile generator'
    def install
      template 'Gemfile.erb', "Gemfile"
    end

  end
end
