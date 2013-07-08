class Publisher
  def self.build_from submission
    response = client.post("my title", "body text", ['test', "testing"])
    puts response.inspect
  end

private
  def self.client
    Wordpress::Client.new(ENV['WORDPRESS_USERNAME'],ENV['WORDPRESS_PASSWORD'], ENV['WORDPRESS_URL'])
  end
end
