class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :destroy]
  
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
    respond_to do |format|
      format.js{render json: @submission.to_json(include: [:songs])}
      format.json{render json: @submission.to_json(include: [:songs])}
      format.html{ redirect_to root_path(id: @submission.id)}
    end
  end

  def new
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      AttachmentBuilder.process(attachment_params, @submission)
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
    params.require(:submission).permit(:title, :body, :user_id, :twitter, :email)
  end

  def attachment_params
    items = {}
    items[:youtube]     = params[:youtube]
    items[:soundcloud]  = params[:soundcloud]
    items[:bandcamp]    = params[:bandcamp]
    items
  end
end
