class UserSongTag < ActiveRecord::Base

  belongs_to :user
  belongs_to :song
  belongs_to :tag

  validates :user_id, presence: true, numericality: true
  validates :song_id, presence: true, numericality: true
  validates :tag_id, presence: true, numericality: true
end
