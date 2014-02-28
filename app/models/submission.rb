class Submission < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true
  validates :twitter, presence: true
  validates :email, presence: true
  has_many :songs
  validate :associated_songs

  def associated_songs
    errors.add(:songs, 'Must Have At Least 1 Song') unless self.songs.length > 0
  end

  accepts_nested_attributes_for :songs, reject_if: :missing_url?

  def missing_url?(attributes)
    !(/\A(?:https?:\/\/soundcloud\.com)\/.+\/.+/ === attributes['url']) && !attributes['url'].include?('/sets/')
  end

  scope :latest, -> { order("created_at DESC") }

  after_save :resolve_songs
  def resolve_songs
    songs.each do |s|
      s.resolve
    end
  end

  def next
    Submission.where(id: id + 1).first
  end

  def previous
    Submission.where(id: id - 1).first
  end

  def to_param
    "#{id}-#{title[0,20]}".parameterize
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
