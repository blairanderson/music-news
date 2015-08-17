class WordpressPost
  def self.site
    @@site ||= "http://admin.thatmusicblog.com".freeze
  end

  def self.all
    HTTParty.get("#{site}/wp-json/posts")
  end

  def self.find(id)
    HTTParty.get("#{site}/wp-json/posts/#{id}")
  end
end


