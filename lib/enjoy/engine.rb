module Enjoy
    class Engine < ::Rails::Engine
      # isolate_namespace Enjoy

    # rake_tasks do
    #   require File.expand_path('../tasks', __FILE__)
    # end

    initializer "enjoy_cms.email_defaults" do
      # Write default email settings to DB so they can be changed.

      #temp
      # begin
      #   if Settings and Settings.table_exists?
      #     Settings.default_email_from(default: 'noreply@site.domain')
      #     Settings.form_email(default: 'admin@site.domain')
      #     Settings.email_topic(default: 'с сайта')
      #   end
      # rescue
      # end
    end
    initializer 'enjoy_cms.paperclip' do
      # require 'paperclip/style'
      # module ::Paperclip
      #   class Style
      #     alias_method :processor_options_without_auto_orient, :processor_options
      #     def processor_options
      #       processor_options_without_auto_orient.merge(auto_orient: false)
      #     end
      #   end
      # end
    end

    config.after_initialize do
      # trigger autoload so models are registered in Mongoid::Elasticearch
      # Enjoy.config.search_models.map(&:constantize)

      # Write default email settings to DB so they can be changed.
      # if Settings and Settings.table_exists?
      #   Settings.default_email_from(default: 'noreply@site.domain')
      #   Settings.form_email(default: 'admin@site.domain')
      #   Settings.email_topic(default: 'с сайта')
      # end
    end
  end
end
