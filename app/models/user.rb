class User < ActiveRecord::Base
  has_many :user_song_tags, dependent: :destroy
  has_many :songs, through: :user_song_tags
end
