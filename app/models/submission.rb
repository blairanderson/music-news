class Submission < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  scope :popular, -> { where("created_at >= ?", 2.week.ago.utc).order("created_at DESC") }

    # Post.where("created_at >= ?", 1.week.ago.utc).order("votes_count DESC, created_at DESC")


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
