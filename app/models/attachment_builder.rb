class AttachmentBuilder

  def self.process(items, submission )
    process_youtube(items[:youtube], submission)
    process_soundcloud(items[:soundcloud], submission)
    process_bandcamp(items[:bandcamp], submission)
  end

  def self.process_youtube(items, submission)
    items.each{|_i, url| Youtube.process(url, submission, "Youtube".to_sym)}
  end

  def self.process_soundcloud(items, submission)
    items.each{|_i, url| Song.process(url, submission, "Soundcloud")}
  end

  def self.process_bandcamp(items, submission)
    items.each{|_i, url| Song.process(url, submission, "Bandcamp")}
  end

end
