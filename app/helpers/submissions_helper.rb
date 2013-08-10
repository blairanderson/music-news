module SubmissionsHelper

  def soundcloud_link(soundcloud_url)
    link_to cleanup(soundcloud_url), soundcloud_url, target: "_blank"
  end

  def cleanup(url)
    url.gsub('https://','').gsub('http://', '').gsub('soundcloud.com/','')
  end

  def clean_title(title)
    if title.nil?
      "learn more..."
    else
      title[0..25]
    end
  end
end
