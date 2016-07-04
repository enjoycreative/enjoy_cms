require 'rails/generators'

module Enjoy::Cms
  class PaperclipOptimizerGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy CMS paperclip_optimizer Config generator'
    def install
      template 'paperclip_optimizer.erb', "config/initializers/paperclip_optimizer.rb"
    end

  end
end
