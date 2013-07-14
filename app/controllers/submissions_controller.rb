class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  # before_filter :require_admin, only: [:index]
  
  def index
    @submissions = Submission.latest.limit(10)
  end

  # def pop
  #   This needs to happen after popularity is created
  #   @submissions = Submission.all
  # end

  def feed
    @submissions = Submission.latest.limit(5)
    
    respond_to do |format|
      format.rss  { render rss: @submissions }
      format.html { redirect_to feed_path(format: :json)}
      format.json  { render json: @submissions.to_json(include: [:songs])}
    end
  end

  def twitter
    @submissions = Submission.where(twitter: params[:twitter])
    render 'submissions/index'
  end

  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        AttachmentBuilder.process(attachment_params, @submission)
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render action: 'show', status: :created, location: @submission }
      else
        format.html { render action: 'new' }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
