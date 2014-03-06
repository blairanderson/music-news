# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_song_tag, :class => 'UserSongTag' do
    user
    song
    tag
  end
end
