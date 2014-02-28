class SubmissionsController < ApplicationController
  include ApiHelper
  before_action :set_submission, only: [:show, :destroy, :resolve]

  def index
    @submissions = Submission.latest.includes(:songs).page params[:page]
    render json: @submissions, meta: paginate(@submissions), meta_key: 'pagingData'
  end

  def show
    @submission.increment!(:view_count)
    render json: @submission, root: false
  end

  def resolve
    @submission.songs.each do |s|
      s.resolve
      sleep 1
    end
    render json: @submission, root: false
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to root_path, notice: 'Submission was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @submission.destroy
    render json: @submission, root: false
  end

private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :body, :user_id, :twitter, :email, songs_attributes:[:url])
  end
end
