class Publisher

  # this is for expiramentation. 
  def self.setup
    url = "http://seainhd.com/?json=get_nonce&controller=posts&method=create_post"
    result = HTTParty.get(url)
    puts result
    result['nonce']
  end

  def self.publish
    # options = {
    #   nonce: setup,
    #   title: "title",
    #   content: "content",
    #   status: "draft"
    # }
    # url = "http://seainhd.com/?json=posts.create_post"
    url = "http://seainhd.com/?json=posts.create_post&nonce=89d798844c&title=awesome&body=greatbody"
    response = HTTParty.get(url)
  end
end
