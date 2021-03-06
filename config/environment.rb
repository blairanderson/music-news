# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  port: '25',
  address: ENV['POSTMARK_SMTP_SERVER'],
  user_name: ENV['POSTMARK_API_KEY'],
  password: ENV['POSTMARK_API_KEY'],
  domain: 'seainhd.com',
  authentication: :plain,
}
ActionMailer::Base.delivery_method = :smtp
