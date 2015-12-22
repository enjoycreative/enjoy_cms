lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enjoy/version'

Gem::Specification.new do |spec|
  spec.name          = 'enjoy_cms_mongoid'
  spec.version       = Enjoy::VERSION
  spec.authors       = ['Alexander Kiseliev']
  spec.email         = "admin@enjoycreate.ru"
  spec.description   = %q{EnjoyCMS - Mongoid metapackage}
  spec.summary       = %q{}
  spec.homepage      = 'https://github.com/enjoycreative/enjoy_cms'
  spec.license       = 'MIT'

  spec.files         = %w(lib/enjoy_cms_mongoid.rb)
  spec.executables   = []
  spec.test_files    = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'mongoid', ['>= 4.0.0', '< 6.0']
  spec.add_dependency 'enjoy_cms', Enjoy::VERSION
Enjoy
  spec.add_dependency 'glebtv-mongoid_nested_set'
  spec.add_dependency 'glebtv-mongoid-paperclip'

  spec.add_dependency 'mongoid-audit', '~> 1.1.0'
  spec.add_dependency 'mongoid_slug'

  spec.add_dependency 'mongo_session_store-rails4'
  spec.add_dependency 'rails_admin_settings'
end
