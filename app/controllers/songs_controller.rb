class SongsController < ApplicationController
  include ApiHelper
  before_action :set_song, only: [:show, :destroy, :update]

  def index
    @songs = Song.playable.greatest.latest.page params[:page]
    render json: @songs, meta: paginate(@songs), meta_key: 'pagingData'
  end

  def show
    @song.resolve
    render json: @song, root: false
  end

  def destroy
    @song.destroy
    render json: @song, root: false
  end

  def update
    @song.inactive! if song_invalidation_params[:invalid]
    head :ok
  end

  def set_song
    @song = Song.find(params[:id])
  end

private
  def song_invalidation_params
    params.permit(:invalid)
  end

  def song_params
    params.require(:song).permit(:invalid, :id)
  end
end
