module Enjoy
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :main_index_layout
    attr_accessor :error_layout

    attr_accessor :search_enabled
    attr_accessor :search_per_page
    attr_accessor :search_models

    attr_accessor :contacts_captcha
    attr_accessor :contacts_fields
    attr_accessor :contacts_message_required
    attr_accessor :contacts_captcha_error_message

    attr_accessor :localize

    attr_accessor :recreate_contact_message_action

    attr_accessor :ability_manager_config
    attr_accessor :ability_admin_config

    def initialize
      @main_index_layout = 'application'
      @error_layout = 'application'
      @menu_max_depth = 2

      @search_enabled = false
      @search_per_page = 10
      @search_models = []

      @localize = false

      @ability_manager_config = []
      @ability_manager_config << {
        method: :can,
        model: RailsAdminSettings::Setting,
        actions: [:edit, :update]
      }
      @ability_admin_config = []
      @ability_admin_config << {
        method: :can,
        model: RailsAdminSettings::Setting,
        actions: :manage
      }
    end
  end
end
