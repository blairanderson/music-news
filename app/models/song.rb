class Song < ActiveRecord::Base
  include Attachment
  self.inheritance_column = :_type_disabled

  belongs_to :submission
  scope :soundclouds, -> { where(type: "Soundcloud") }
  scope :bandcamps, -> { where(type: "Bandcamp") }

  validates :url, :format => { :with => /\A(?:https?:\/\/soundcloud\.com)\/.*/ }

  def fetch_details
    resolve && get_stats
  end

  def get_stats
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
    begin
      track = client.get('/resolve', :url => url)
      
      update(stream_url: track.stream_url)
      update(comment_count: track.comment_count)
      update(download_count: track.download_count)
      update(playback_count: track.playback_count)
      update(favoritings_count:  track.favoritings_count)
      update(active: "true")

      track
    rescue
      update(active: "false")
    end    
  end

  def resolve
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
    begin
      track = client.get('/oembed', :url => url)
      
      update(title: track.title)
      update(embed: track.html)
      update(active: "true")
      update(thumbnail_url: track.thumbnail_url)

      track
    rescue
      update(active: "false")
    end
  end

end
