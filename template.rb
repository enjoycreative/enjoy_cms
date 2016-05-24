rails_spec = (Gem.loaded_specs["railties"] || Gem.loaded_specs["rails"])
version = rails_spec.version.to_s

mongoid = options[:skip_active_record]

if Gem::Version.new(version) < Gem::Version.new('4.2.6')
  puts "You are using an old version of Rails (#{version})"
  puts "Please update"
  puts "Stopping"
  exit 1
end

remove_file 'Gemfile'
create_file 'Gemfile' do <<-TEXT
source 'https://rubygems.org'

gem 'rails', '4.2.6' #'~> 5.0.0.rc1'
#{if mongoid then "gem 'mongoid'" else "gem 'pg'" end}

gem 'sass'
gem 'sass-rails'
gem 'compass'
gem 'compass-rails'

gem 'ack-paperclip-meta', github: "enjoycreative/ack-paperclip-meta"#, path: '/home/ack/www/paperclip-meta'

gem 'rails_admin_multiple_file_upload'
gem 'rails_admin_comments', github: "enjoycreative/rails_admin_comments" #path: '/home/ack/www/rails_admin/rails_admin_comments'


##{if mongoid then "gem 'enjoy_cms_mongoid'" else "gem 'enjoy_cms_activerecord'" end}, path: '/home/ack/www/enjoy/enjoy_cms' #'~> 0.4.0.beta1'
#{if mongoid then "gem 'enjoy_cms_mongoid'" else "gem 'enjoy_cms_activerecord'" end}, github: "enjoycreative/enjoy_cms" #'~> 0.4.0.beta1'

gem 'devise'

gem 'slim-rails'
gem 'rs_russian'
gem 'cancancan'

# gem 'cloner'
gem 'unicorn'
gem 'x-real-ip'

#temp
#gem 'sentry-raven'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'spring'

  # gem 'capistrano', require: false
  #
  # gem 'rvm1-capistrano3', require: false
  # gem 'glebtv-capistrano-unicorn', require: false
  # gem 'capistrano-bundler', require: false
  # gem 'capistrano-rails', require: false

  # gem 'hipchat'
  # gem 'coffee-rails-source-maps'
  # gem 'compass-rails-source-maps'

  gem 'ack_favicon_maker_rails', github: 'ack43/favicon_maker_rails'

  #gem 'rails_email_preview', '~> 1.0.3'

  gem 'image_optim_pack'
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'email_spec'
  #{if mongoid then "gem 'mongoid-rspec'" else "" end}
  gem 'ffaker'
  gem 'factory_girl_rails'
end

#{if mongoid then "#gem 'mongo_session_store-rails4'" else "#gem 'activerecord-session_store'" end}

gem 'slim'
gem 'sprockets'

gem 'uglifier'

group :production do
  gem "god"
end
TEXT
end

remove_file '.gitignore'
create_file '.gitignore' do <<-TEXT
# See https://help.github.com/articles/ignoring-files for more about ignoring files.
#
# If you find yourself ignoring temporary files generated by your text editor
# or operating system, you probably want to add a global ignore instead:
#   git config --global core.excludesfile '~/.gitignore_global'
.idea
.idea/*

/.bundle
/log/*.log
/tmp/*
/public/assets
/public/ckeditor_assets
Gemfile.lock
TEXT
end

create_file 'extra/.gitkeep', ''

if mongoid
remove_file 'config/initializers/cookies_serializer.rb'
create_file 'config/initializers/cookies_serializer.rb' do  <<-TEXT
# Be sure to restart your server when you modify this file.
# json serializer breaks Devise + Mongoid. DO NOT ENABLE
# See https://github.com/plataformatec/devise/pull/2882
# Rails.application.config.action_dispatch.cookies_serializer = :json
Rails.application.config.action_dispatch.cookies_serializer = :marshal
TEXT
end
end

remove_file 'config/initializers/session_store.rb'
if mongoid
create_file 'config/initializers/session_store.rb' do  <<-TEXT
# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_#{app_name.tableize.singularize}_session'
Rails.application.config.session_store :mongoid_store

TEXT
end
else
generate 'active_record_store:session_migration'
create_file 'config/initializers/session_store.rb' do  <<-TEXT
# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_#{app_name.tableize.singularize}_session'
Rails.application.config.session_store :active_record_store

TEXT
end
end

remove_file 'app/controllers/application_controller.rb'
create_file 'app/controllers/application_controller.rb' do <<-TEXT
class ApplicationController < ActionController::Base
  include Enjoy::Controller
end
TEXT
end

create_file 'config/navigation.rb' do <<-TEXT
# empty file to please simple_navigation, we are not using it
# See https://github.com/enjoycreative/enjoy_cms/blob/master/app/controllers/concerns/enjoy/menu.rb
TEXT
end

create_file 'README.md', "## #{app_name}\nProject generated by EnjoyCMS\nORM: #{if mongoid then 'Mongoid' else 'ActiveRecord' end}\n\n"

create_file '.ruby-version', "2.2.3\n"
create_file '.ruby-gemset', "#{app_name}\n"

run 'bundle install --without production'

if mongoid
create_file 'config/mongoid.yml' do <<-TEXT
development:
  clients:
    default:
      database: #{app_name.downcase}
      hosts:
          - localhost:27017
production:
  clients:
    default:
      database: #{app_name.downcase}
      hosts:
          - localhost:27017
test:
  clients:
    default:
      database: #{app_name.downcase}_test
      hosts:
          - localhost:27017
TEXT
end
else
remove_file 'config/database.yml'
create_file 'config/database.yml' do <<-TEXT
development:
  adapter: postgresql
  encoding: unicode
  database: #{app_name.downcase}_development
  pool: 5
  username: #{app_name.downcase}
  password: #{app_name.downcase}
  template: template0
TEXT
end
say "Please create a PostgreSQL user #{app_name.downcase} with password #{app_name.downcase} and a database #{app_name.downcase}_development owned by him for development NOW.", :red
ask("Press <enter> when done.", true)
end
remove_file 'config/application.rb'
create_file 'config/application.rb' do <<-TEXT
require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
#{'#' if mongoid}require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie" # mailer is off by default
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module #{app_name.camelize}
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
      g.view_specs false
      g.helper_specs false
      g.feature_specs false
      g.template_engine :slim
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.i18n.locale = :ru
    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]
    config.i18n.enforce_available_locales = true
    #{'config.active_record.schema_format = :sql' unless mongoid}

    #{'config.autoload_paths += %W(#{config.root}/extra)'}
    #{'config.eager_load_paths += %W(#{config.root}/extra)'}

    config.time_zone = 'Europe/Moscow'
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
TEXT
end


generate "simple_form:install"

# generate 'paperclip_optimizer:install'
# remove_file 'config/initializers/paperclip_optimizer.rb'
# generate "enjoy:paperclip_optimizer"

# generate 'rails_email_preview:install'
# remove_file 'app/mailer_previews/contact_mailer_preview.rb'
# create_file 'app/mailer_previews/contact_mailer_preview.rb' do <<-TEXT
# class ContactMailerPreview
#   def new_message_email
#     Enjoy::Feedback::ContactMailer.new_message_email(Enjoy::Feedback::ContactMessage.all.to_a.sample)
#   end
# end
# TEXT
# end

unless mongoid
  generate 'simple_captcha'
end

generate "devise:install"
inject_into_file 'config/initializers/devise.rb', before: /^end/ do <<-TEXT

Rails.application.config.to_prepare do
  Devise::SessionsController.layout       "enjoy/devise/sessions"
  Devise::RegistrationsController.layout  "enjoy/devise/registrations"
  Devise::ConfirmationsController.layout  "enjoy/devise/confirmations"
  Devise::UnlocksController.layout        "enjoy/devise/unlocks"
  Devise::PasswordsController.layout      "enjoy/devise/passwords"
end
TEXT
end


generate "devise", "User"
remove_file "config/locales/devise.en.yml"
remove_file "config/locales/en.yml"

gsub_file 'app/models/user.rb', '# :confirmable, :lockable, :timeoutable and :omniauthable', '# :confirmable, :registerable, :timeoutable and :omniauthable'
gsub_file 'app/models/user.rb', ':registerable,', ' :lockable,'
if mongoid
gsub_file 'app/models/user.rb', '# field :failed_attempts', 'field :failed_attempts'
gsub_file 'app/models/user.rb', '# field :unlock_token', 'field :unlock_token'
gsub_file 'app/models/user.rb', '# field :locked_at', 'field :locked_at'

inject_into_file 'app/models/user.rb', before: /^end/ do <<-TEXT

  field :name,    type: String
  field :login,   type: String
  field :roles,   type: Array, default: []

  before_save do
    self.roles ||= []
    self.roles.reject! { |r| r.blank? }
  end

  AVAILABLE_ROLES = ["admin", "manager", "client"]

  AVAILABLE_ROLES.each do |r|
    class_eval <<-EVAL
      def \#{r}?
        self.roles and self.roles.include?("\#{r}")
      end

      scope :\#{r.pluralize}, -> { any_in(roles: "\#{r}") }
    EVAL
  end

  rails_admin do
    list do
      field :email
      field :name
      field :login
      field :roles do
        pretty_value do
          render_object = (bindings[:controller] || bindings[:view])
          render_object.content_tag(:p, bindings[:object].roles.join(", "))
        end
      end
    end

    edit do
      group :login do
        active false
        field :email, :string do
          visible do
            render_object = (bindings[:controller] || bindings[:view])
            render_object.current_user.admin? or (render_object.current_user.manager? and render_object.current_user == bindings[:object])
          end
        end
        field :name, :string
        field :login, :string do
          visible do
            render_object = (bindings[:controller] || bindings[:view])
            render_object.current_user.admin?
          end
        end
      end

      group :roles do
        active false
        field :roles, :enum do
          enum do
            AVAILABLE_ROLES
          end

          multiple do
            true
          end

          visible do
            render_object = (bindings[:controller] || bindings[:view])
            render_object.current_user.admin?
          end
        end
      end

      group :password do
        active false
        field :password do
          visible do
            render_object = (bindings[:controller] || bindings[:view])
            render_object.current_user.admin? or render_object.current_user == bindings[:object]
          end
        end
        field :password_confirmation do
          visible do
            render_object = (bindings[:controller] || bindings[:view])
            render_object.current_user.admin? or render_object.current_user == bindings[:object]
          end
        end
      end
    end

  end
TEXT
end
end

if mongoid
  generate "ckeditor:install", "--orm=mongoid", "--backend=paperclip"
else
  generate "ckeditor:install", "--orm=active_record", "--backend=paperclip"
end

unless mongoid
  generate "enjoy:migration"
  generate "rails_admin_settings:migration"
end

generate "enjoy:admin"
generate "enjoy:ability"
generate "enjoy:layout"
remove_file 'app/views/layouts/application.html.erb'


unless mongoid
  rake "db:migrate"
end

generate "rspec:install"

remove_file 'config/routes.rb'
create_file 'config/routes.rb' do <<-TEXT
Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  enjoy_cms_routes
end
TEXT
end

create_file 'config/locales/ru.yml' do <<-TEXT
ru:
  attributes:
    is_default: По умолчанию
  mongoid:
    models:
      item: Товар
    attributes:
      item:
        price: Цена
TEXT
end

# remove_file 'db/seeds.rb'
#
# require 'securerandom'
# admin_pw = SecureRandom.urlsafe_base64(6)
# create_file 'db/seeds.rb' do <<-TEXT
# admin_pw = "#{admin_pw}"
# User.destroy_all
# User.create!(email: 'admin@#{app_name.dasherize.downcase}.ru', password: admin_pw, password_confirmation: admin_pw, roles: ["admin"])
# TEXT
# end


generate "enjoy:rack"


remove_file 'app/assets/stylesheets/application.css'
remove_file 'app/assets/javascripts/application.js'
generate "enjoy:assets", app_name

remove_file 'public/robots.txt'
generate "enjoy:robots"


#god+unicorn
generate "enjoy:unicorn_god", app_name



#scripts
generate "enjoy:scripts", app_name



if mongoid
  FileUtils.cp(Pathname.new(destination_root).join('config', 'mongoid.yml').to_s, Pathname.new(destination_root).join('config', 'mongoid.yml.example').to_s)
else
  FileUtils.cp(Pathname.new(destination_root).join('config', 'database.yml').to_s, Pathname.new(destination_root).join('config', 'database.yml.example').to_s)
end

FileUtils.cp(Pathname.new(destination_root).join('config', 'secrets.yml').to_s, Pathname.new(destination_root).join('config', 'secrets.yml.example').to_s)

unless mongoid
  generate "paper_trail:install"
  generate "friendly_id"
  rake "db:migrate"
end

git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
