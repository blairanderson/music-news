class SongsController < ApplicationController
  before_action :set_song, only: [:show, :backbone_redirect]

  def index
    if params[:sort] == 'popular'
      @songs = Song.order("created_at DESC")
    else
      @songs = Song.order("created_at DESC")
    end
    render json: @songs.to_json
  end

  def show
    @song.resolve
    render json: @song
  end

  def destroy
    @song.destroy
    render json: @song
  end

  def set_song
    @song = Song.find(params[:id])
  end
end
