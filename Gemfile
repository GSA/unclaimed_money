source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'json', '1.7.7'
gem 'haml-rails'
gem 'httparty'
gem 'jquery-rails'
gem 'nokogiri'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails' # you need this or you get an err
  gem 'zurb-foundation', '~> 4.0.0'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'hpricot'
  gem 'meta_request'
  gem 'mysql2'
  gem 'quiet_assets'
  gem 'ruby_parser'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'webmock'
end