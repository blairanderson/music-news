class AttachmentBuilder

  def self.process(items, submission )
    process_youtube(items[:youtube], submission)
    process_soundcloud(items[:soundcloud], submission)
    process_bandcamp(items[:bandcamp], submission)
  end

  def self.process_youtube(items, submission)
    items.each{|_i, url| Youtube.process(url, submission)}
  end

  def self.process_soundcloud(items, submission)
    items.each{|_i, url| Soundcloud.process(url, submission)}
  end

  def self.process_bandcamp(items, submission)
    items.each{|_i, url| Bandcamp.process(url, submission)}
  end

end
