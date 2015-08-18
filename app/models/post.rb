class Post < ActiveRecord::Base
  serialize :author
  serialize :raw_data

  def self.published
    where(status: "publish").order(published: :desc)
  end

  def self.with_images
    where.not(image: nil)
  end

  def to_param
    "#{resource_id}-#{slug}"
  end

  def author_name
    author["username"]
  end

  def author_image
    author["avatar"]
  end

  def content
    raw_data["content"]
  end

  def excerpt
    raw_data["excerpt"]
  end
end
