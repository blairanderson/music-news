class WordpressSync
  class << self
    def client
      WordpressPost
    end

    def repo
      Post
    end

    def fetch(id=nil)
      if id
        fetch_by_id(id)
      else
        fetch_all
      end
    end

    def fetch_all
      client.all.each { |resource| sync(resource) }
    end

    def fetch_by_id(id)
      sync(client.find(id))
    end

    def sync(resource=nil)
      post = repo.where(resource_id: resource["ID"]).first_or_create
      post.raw_data = resource
      post.title = resource["title"]
      post.status = resource["status"]
      post.slug = resource["slug"]
      post.resource_type = resource["type"]
      post.author = resource["author"]
      post.published = DateTime.parse(resource["date"])
      if resource["featured_image"] && resource["featured_image"]["ID"]
        post.image = resource["featured_image"]["guid"]
      end
      post.save
    end
  end
end


