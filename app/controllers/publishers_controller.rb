class PublishersController < ApplicationController
  before_filter :require_admin, only: [:new, :create]
  before_action :set_submission, only: [:new, :create]
  
  def new
    @article = Publisher.build_article(@submission)
  end

  def create
    article = Publisher.build_article(@submission)
    article.url = "http://seainhd.com/?p=13190&preview=1"
    @article = article
  end

  def show
  end

private
  def set_submission
    @submission = Submission.find(params[:submission_id])
  end
  
end
