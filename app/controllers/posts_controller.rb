class PostsController < ApplicationController
  def index
    @posts = Post.published.limit(10)
    @submissions = Submission.latest.limit(20)
  end

  def show
    @post = Post.find_by_resource_id!(params[:resource_id])
  end
end
