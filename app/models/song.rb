class Song < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :submission, counter_cache: true
  scope :soundclouds, -> { where(type: "Soundcloud") }
  scope :playable, -> { where.not(stream_url: nil) }
  scope :greatest, -> { order(playback_count: :desc) }
  scope :latest, -> { order(created_at: :desc) }

  validates :url, presence: true

  def has_details?
     stream_url?
  end

  def need_details?
    !has_details?
  end

  def resolve
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
    begin
      track = client.get('/oembed', :url => url)

      update(title: track.title)
      update(embed: track.html)
      update(active: "true")
      update(thumbnail_url: track.thumbnail_url)

      track = client.get('/resolve', :url => url)
      update(stream_url: track.stream_url)
      update(comment_count: track.comment_count)
      update(download_count: track.download_count)
      update(playback_count: track.playback_count)
      update(favoritings_count:  track.favoritings_count)

      track
    rescue
      update(active: "false")
    end
  end
end
