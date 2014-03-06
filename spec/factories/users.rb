# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :class => 'User' do
    provider { %w(twitter).sample }
    uid { Faker::Number.number(10) }
    name { [Faker::Name.first_name, Faker::Name.last_name].join }
    keychain
  end
end
