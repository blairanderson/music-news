class AttachmentBuilder

  def self.process(items, submission )
    process_soundcloud(items[:soundcloud], submission)
  end

  def self.process_soundcloud(items, submission)
    items.each{|_i, url| Song.process(url, submission, "Soundcloud")}
  end
end
