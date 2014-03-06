class UserSongTag < ActiveRecord::Base

  belongs_to :user
  belongs_to :song
  belongs_to :tag

  validates :song_id, presence: true, numericality: true
  validates :tag_id, presence: true, numericality: true
  validates :user_id,
    presence: true,
    numericality: true,
    uniqueness: {
      scope: [:tag_id, :song_id],
      message: "user song tag already exists"
    }
end
