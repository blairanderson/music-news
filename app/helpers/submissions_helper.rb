module SubmissionsHelper
  def soundcloud_embed(song)
    url = "http://soundcloud.com/oembed.json?url=#{song.url}&color=000000"
    response = HTTParty.get(url)
    response["html"].html_safe
  end
end
