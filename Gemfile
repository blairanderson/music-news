ruby '2.0.0'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'unicorn'
gem 'simple_form'
gem 'haml-rails'
gem 'haml'
gem 'newrelic_rpm'
gem 'wordpress', git: 'https://github.com/jordandobson/wordpress'
gem 'raredio', git: 'https://github.com/blairanderson/rawrdio-rb'
gem 'soundcloud'
gem 'active_model_serializers'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter'
gem 'rack-cors', :require => 'rack/cors'
gem 'figaro'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :test do
  gem 'vcr', '2.8.0'
  gem 'webmock', '1.16'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'guard-rspec'
  gem 'sqlite3'
  gem 'capybara'
  gem 'rspec-rails', '~> 2.0'
  gem 'launchy'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'compass-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'font-awesome-rails', git: 'https://github.com/blairanderson/font-awesome-rails'
gem 'backbone-on-rails'