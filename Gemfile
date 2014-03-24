ruby '2.1.0'
source 'https://rubygems.org'

gem 'rails', '4.0.3'
gem 'simple_form'
gem 'haml-rails'
gem 'haml'
gem 'wordpress', git: 'https://github.com/jordandobson/wordpress'
gem 'raredio', git: 'https://github.com/blairanderson/rawrdio-rb'
gem 'soundcloud'
gem 'active_model_serializers'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter'
gem 'rack-cors', :require => 'rack/cors'
gem 'figaro'
gem 'simple_enum'
gem 'kaminari'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'compass-rails'
gem 'bootstrap-sass', git: 'https://github.com/blairanderson/bootstrap-sass.git'
gem 'font-awesome-rails', git: 'https://github.com/blairanderson/font-awesome-rails'
gem 'backbone-on-rails', '1.1.0.0'
gem 'momentjs-rails', '2.4.0'

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

group :test do
  gem 'sqlite3'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'vcr', '2.8.0'
  gem 'webmock', '1.16'
  gem 'simplecov', '~> 0.7.1', :require => false, :group => :test
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'rspec-rails', '~> 2.0'
  gem 'launchy'
end

group :development do
  # gem 'sqlite3'
  gem 'pg'
  gem 'better_errors'
  gem 'binding_of_caller'
end
