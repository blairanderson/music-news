class Publisher
  def self.build_from submission 
    begin
      response = client.post("my title", "body text", ['test', "testing"])
    rescue
      "Error"
    end
  end

private
  def self.client
    Wordpress::Client.new(ENV['WORDPRESS_USERNAME'],ENV['WORDPRESS_PASSWORD'], ENV['WORDPRESS_URL'])
  end
end
