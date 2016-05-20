lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enjoy/version'

Gem::Specification.new do |spec|
  spec.name          = 'enjoy_cms'
  spec.version       = Enjoy::VERSION
  spec.authors       = ['Alexander Kiseliev']
  spec.email         = ["dev@enjoycreate.ru"]
  spec.description   = %q{EnjoyCMS }
  spec.summary       = %q{Please DO NOT use this gem directly, use enjoy_cms_mongoid or enjoy_cms_activerecord instead!}
  spec.homepage      = 'https://github.com/enjoycreative/enjoy_cms'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/).reject {|f| f.start_with?('mongoid') || f.start_with?('activerecord') }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'rails', '4.2.6' #'~> 5.0.0.rc1'

  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'simple_form'
  spec.add_dependency 'glebtv-simple_captcha'
  # spec.add_dependency 'galetahub-simple_captcha'
  spec.add_dependency 'coffee-rails'
  spec.add_dependency 'devise'

  spec.add_dependency 'ckeditor'
  spec.add_dependency 'geocoder'

  spec.add_dependency 'rails_admin', '~> 0.8.0'
  spec.add_dependency 'rails_admin_nested_set'
  spec.add_dependency 'rails_admin_toggleable'

  spec.add_dependency 'rails_admin_settings'
end
