class Submission < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true
  validates :twitter, presence: true
  validates :email, presence: true
  scope :popular, -> { where("created_at >= ?", 2.week.ago.utc).order("created_at DESC") }

  def songs
    Song.where(submission_id: self.id)
  end

  def videos
    Video.where(submission_id: self.id)
  end

  def attachments
    songs.concat(videos)
  end

end
