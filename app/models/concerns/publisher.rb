class Publisher
  attr_reader :title, :body, :url

  def initialize(args = {})
    @title = args[:title]
    @body = args[:body]
  end

  def self.build_article submission 
    title = "Listen: Some Music from @#{submission.twitter}"
    body = ""

    submission.soundclouds.each_with_index do |song, index|
      unless song.active == "true"
        song.resolve
      end
      body << "<h2>#{song.title}</h2>"
      body << "\n"
      body << "<br>"
      body << "\n"
      body << song.embed
      body << "\n"
      body << "<br>"
      body << "\n"
      if index == 0
        body << "<img width=\"100%\" src=\"#{song.thumbnail_url}\">"
      end
      body << "\n"
      body << "<br>"
      body << "\n"
    end

    new(title: title, body: body)
  end

  def send_to_wordpress
    begin
      response = client.post(title, body, ['music', "mp3"])
      {"rsp"=>{"post"=>{"title"=>"Listen: Some Music from @yuni", "url"=>"http://seainhd.com/?p=13202&preview=1", "id"=>"13202&action=edit"}, "stat"=>"ok"}}
      @url = response["rsp"]["post"]["url"]
    rescue
      "Error"
    end
  end

private
  def client
    Wordpress::Client.new(ENV['WORDPRESS_USERNAME'],ENV['WORDPRESS_PASSWORD'], ENV['WORDPRESS_URL'])
  end
end
