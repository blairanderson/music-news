class Tag < ActiveRecord::Base
  has_many :user_song_tags, dependent: :destroy
  has_many :songs, through: :user_song_tags
  has_many :users, through: :user_song_tags

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }
end
