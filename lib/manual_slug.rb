module ManualSlug
  autoload :Mongoid,      'manual_slug/mongoid'
  autoload :ActiveRecord, 'manual_slug/active_record'
  extend ActiveSupport::Concern
  if Enjoy.mongoid?
    include ManualSlug::Mongoid
  else
    include ManualSlug::ActiveRecord
  end
end
