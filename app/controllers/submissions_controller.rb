class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :destroy, :resolve]

  def index
    @submissions = Submission.latest.includes(:songs).limit(50)
    render json: @submissions.to_json(include: [:songs])
  end

  def show
    @submission.increment!(:view_count)
    render json: @submission.to_json(include: [:songs])
  end

  def resolve
    @submission.songs.each do |s|
      s.resolve
      sleep 1
    end
    render json: @submission
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to root_path(id: @submission.id), notice: 'Submission was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @submission.destroy
    render json: @submission
  end

private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :body, :user_id, :twitter, :email, songs_attributes:[:url])
  end
end
