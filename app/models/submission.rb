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

  scope :latest, -> { order("created_at DESC").includes(:songs) }
  scope :soundclouds, -> { where(type: :Soundcloud) }
  scope :bandcamps, -> { where(type: :Bandcamp) }

  after_save :resolve_songs
  def resolve_songs
    songs.each {|s| s.resolve}
  end

  def to_param
    "#{id}-#{title[0,20]}".parameterize
  end
end
