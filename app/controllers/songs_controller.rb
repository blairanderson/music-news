class SongsController < ApplicationController
  before_action :set_song, only: [:show, :backbone_redirect]

  def index
    @songs = Song.order("created_at DESC")
    render json: @songs
  end

  def backbone_redirect
    redirect_to root_path(song: params[:id])
  end

  def show
    @song.resolve
    render json: @song
  end

  def destroy
    binding.pry
    @song.destroy
    render js: "window.location.href = window.location.origin;"
  end

  def set_song
    @song = Song.find(params[:id])
  end
end
