class UserSongTag < ActiveRecord::Base

  belongs_to :user
  belongs_to :song
  belongs_to :tag

  validates :song_id, presence: true, numericality: true
  validates_associated :song

  validates :tag_id, presence: true, uniqueness: {scope: [:user_id, :song_id], message: "cannot create duplicate tag"}
  validates_associated :tag

  validates :user_id, presence: true
end
