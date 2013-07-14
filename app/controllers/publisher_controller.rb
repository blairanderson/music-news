class PublisherController < ApplicationController
  before_action :set_submission, only: [:new, :create, :show]
  def new
  end

  def create
  end

  def show
  end

private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :body, :user_id, :twitter, :email)
  end

end
