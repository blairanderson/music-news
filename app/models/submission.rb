class Submission < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true
  validates :twitter, presence: true
  validates :email, presence: true
  scope :latest, -> { where("created_at >= ?", 7.days.ago.utc).order("created_at DESC") }

  def songs
    Song.where(submission_id: self.id)
  end

  def next
    Submission.where(id: id + 1).first
  end

  def previous
    Submission.where(id: id - 1).first
  end

  def to_param
    "#{id}-#{title[0,20]}-#{body[0,40]}".parameterize
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

  def youtubes
    videos.where(:type == "Youtube".to_sym)
  end

  def bandcamps
    songs.where(:type == "Bandcamp".to_sym)
  end

end
