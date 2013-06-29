class Bandcamp < Song
  include Attachment

  def parse_for_embed
    
  end

  def get_band_and_track_id
    #hit this url with httparty
    # pass the results into the embed url
    "http://api.bandcamp.com/api/url/1/info?key=vatnajokull&url=#{url}"
  end
end
