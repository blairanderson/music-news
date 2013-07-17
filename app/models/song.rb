class Song < ActiveRecord::Base
  include Attachment
  self.inheritance_column = :_type_disabled

  belongs_to :submission
  scope :soundclouds, -> { where(type: "Soundcloud") }
  scope :bandcamps, -> { where(type: "Bandcamp") }

  validates :url, :format => { :with => /\A(?:https?:\/\/soundcloud\.com)\/.*/ }

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
