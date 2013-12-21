class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :destroy, :resolve]
  
  def index
    @submissions = Submission.latest.limit(20)
  end

  def feed
    @submissions = Submission.latest.limit(50)
    render json: @submissions.to_json(include: [:songs])
  end

  def twitter
    @submissions = Submission.where(twitter: params[:twitter])
    render json: @submissions.to_json(include: [:songs])
  end

  def more
    @submissions = Submission.order("created_at DESC")
    render json: @submissions.to_json(include: [:songs])
  end

  def show
    @submission.increment!(:view_count)
    redirect_to bb_submission_path(@submission)
  end

  def resolve
    if @submission.songs.empty?
      @submission.destroy
      path = new_path
    else
      @submission.songs.each do |s|
        s.resolve
        sleep 1
      end
      path = bb_submission_path(@submission)
    end
    redirect_to path
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to resolve_submission_path(@submission), notice: 'Submission was successfully created.'
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
