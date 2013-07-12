ruby '2.0.0'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'
gem 'unicorn'
gem 'simple_form'
gem 'haml-rails'
gem 'haml'
gem 'newrelic_rpm'
gem 'wordpress', git: 'https://github.com/jordandobson/wordpress'
gem 'raredio', git: 'https://github.com/blairanderson/rawrdio-rb'

### http://railscasts.com/episodes/364-active-record-reputation-system?view=asciicast
gem 'activerecord-reputation-system', github: 'NARKOZ/activerecord-reputation-system', branch: 'rails4' 

group :production do 
  gem 'pg'
  gem 'rails_12factor'
end

gem 'simplecov', :require => false, :group => :test

group :test, :development do 
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

gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.0.1'
