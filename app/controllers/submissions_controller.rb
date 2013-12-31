class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :destroy, :resolve]

  def backbone
    render :index
  end

  def index
    @submissions = Submission.latest.includes(:songs).limit(50)
    render json: @submissions.to_json(include: [:songs])
  end

  def backbone_redirect
    redirect_to root_path(id: params[:id])
  end

  def show
    @submission.increment!(:view_count)
    redirect_to root_path(id: @submission.id)
  end

  def resolve
    @submission.songs.each do |s|
      s.resolve
      sleep 1
    end
    redirect_to bb_submission_path(@submission)
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
    redirect_to root_path
  end

private
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :body, :user_id, :twitter, :email, songs_attributes:[:url])
  end
end
