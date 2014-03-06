# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :keychain, :class => 'Keychain' do
    api_token   { "token" }
    api_secret  { "secret" }
  end
end
