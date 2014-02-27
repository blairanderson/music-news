class SongsController < ApplicationController
  before_action :set_song, only: [:show, :destroy, :update]

  def index
    @songs = Song.playable
    @songs = @songs.greatest if params[:sort] == 'popular'
    @songs = @songs.latest

    render json: @songs
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
    @song.destroy if song_invalidation_params[:invalid]
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
