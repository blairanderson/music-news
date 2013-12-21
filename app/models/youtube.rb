class Youtube < Video
  def embed
    @embed || "<iframe id='ytplayer' type='text/html' width='#{embed_width}' height='#{embed_height}' src='#{parse_for_embed + embed_details}' frameborder='0'/>".html_safe
  end

  def parse_for_embed
    url.gsub('http://www.youtube.com/watch?v=', 
      'http://www.youtube.com/embed/')
  end

private

  def embed_details
    '?autoplay=0&origin=http://news.seainhd.com'
  end

  def embed_width
    "100%"
  end

  def embed_height
    "600px"
  end
end
