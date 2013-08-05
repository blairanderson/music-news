module SubmissionsHelper

  def soundcloud_link(soundcloud_url)
    link_to cleanup(soundcloud_url), soundcloud_url, target: "_blank"
  end

  def cleanup(url)
    url.gsub('https://','').gsub('http://', '').gsub('soundcloud.com/','')
  end
end
