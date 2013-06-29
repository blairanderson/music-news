class Soundcloud < Song
  include Attachment

  def embed
    "<iframe id='sc-widget' width='100%' height='166' scrolling='no' frameborder='no' src='#{parsed_for_embed}'></iframe>".html_safe
  end

  def parsed_for_embed
    'https://w.soundcloud.com/player/?url='+url+'&show_artwork=true'
  end
end

