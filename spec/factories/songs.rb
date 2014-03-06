# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song, :class => 'Song' do
    title             { [Faker::Lorem.word, Faker::Lorem.sentence].join }
    type              { "soundcloud" }
    url               { Faker::Internet.url }
    stream_url        { Faker::Internet.url }
    play_count        { 0 }
    comment_count     { 0 }
    download_count    { 0 }
    playback_count    { 0 }
    favoritings_count { 0 }
    status_cd         { 0 }
  end
end
