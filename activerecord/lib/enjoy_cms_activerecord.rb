require 'awesome_nested_set'
require 'paperclip'
require 'paper_trail'
require 'friendly_id'
require 'validates_lengths_from_database'
require 'pg_search'

module Enjoy
  def self.orm
    :active_record
  end
end

require 'enjoy_cms'
