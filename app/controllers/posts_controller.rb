class PostsController < ApplicationController

  def index
    @posts = Post.published.limit(10)
    @songs = Song.playable.latest.limit(50)
  end

  def show
    @post = Post.find_by_resource_id!(params[:resource_id])
  end
end
