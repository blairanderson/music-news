class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :author_name, :author_image
end
