class Submission < ActiveRecord::Base

  validates :title, presence: true
  validates :body, presence: true
  validates :twitter, presence: true
  validates :email, presence: true
  has_many :songs
  accepts_nested_attributes_for :songs, reject_if: :missing_url?

  def missing_url?(attributes)
    !(/\A(?:https?:\/\/soundcloud\.com)\/.*/ === attributes['url'])
  end
  
  scope :latest, -> { order("created_at DESC") }


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

  def self.purge_count
    subs = Submission.where(songs_count: 0).count
    sub_total = Submission.count
    "#{subs} of #{sub_total} without songs."
  end
  

  def self.update_all_song_counts
    Submission.all.each do |s|
      s.update songs_count: s.songs.length
    end
  end

private
  def self.purge
    Submission.where(songs_count: 0).destroy_all
  end
end
