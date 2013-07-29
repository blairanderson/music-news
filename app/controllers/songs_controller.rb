class SongsController < ApplicationController
  before_action :set_song, only: [:show, :resolve]

  def index
    @songs = Song.order("created_at DESC")
    render json: @songs
  end

  def playlist
    @songs = Song.where(active: "true").order("created_at DESC")
    render json: @songs, root: false
  end

  def set_song
    @song = Song.find(params[:id])
  end

  def show
    unless @song.active == "true"
      @song.fetch_details
    end
    render json: @song
  end

  def resolve
    @song.fetch_details
    render json: @song
  end

end
