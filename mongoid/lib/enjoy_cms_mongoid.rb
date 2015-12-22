require 'mongoid'
require 'glebtv-mongoid-paperclip'
require 'glebtv-mongoid_nested_set'
require 'mongoid-audit'
require 'mongoid_slug'
require 'mongo_session_store-rails4'
require 'rails_admin_settings'

module Enjoy
  def self.orm
    :mongoid
  end
end

require 'enjoy_cms'
