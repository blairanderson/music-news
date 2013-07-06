class Submission < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true
  validates :twitter, presence: true
  validates :email, presence: true
  scope :latest, -> { where("created_at >= ?", 3.days.ago.utc).order("created_at DESC") }

  def songs
    Song.where(submission_id: self.id)
  end

  def videos
    Video.where(submission_id: self.id)
  end

  def attachments
    songs.concat(videos)
  end

  def soundclouds
    songs.where(:type == "Soundcloud".to_sym)
  end

  def bandcamps
    songs.where(:type == "Bandcamp".to_sym)
  end

end
