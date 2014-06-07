class PublishersController < ApplicationController
  before_filter :require_admin, only: [:new, :create, :show]
  before_action :set_submission, only: [:new, :create, :show]

  def new
    @article = Publisher.build_article(@submission)
  end

  def create
    @article = Publisher.build_article(@submission)
    @article.send_to_wordpress
  end

  def show
  end

private
  def set_submission
    @submission = Submission.find(params[:submission_id])
  end
end
