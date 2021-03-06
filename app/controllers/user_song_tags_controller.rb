class UserSongTagsController < ApplicationController
  before_action :set_keychain
  before_action :set_user
  before_action :set_tag, only: [:create]

  def index
    @favorites = @user.songs
    render json: @favorites
  end

  def create
    @favorite = UserSongTag.where(valid_favorite).first_or_initialize
    @favorite.save
    render json: @favorite
  end

  def destroy
    favorite = @user.user_song_tags.where(id: params[:id]).first
    if favorite
      favorite.destroy
      render json: {success: "favorite deleted"}
    else
      render :unprocessable_entity
    end
  end

private

  def valid_favorite
    user_song_tag_params.slice(:song_id).merge({user_id: @user.id,tag_id: @tag.id})
  end

  def user_song_tag_params
    params.require(:user_song_tag).permit(:song_id, :tag)
  end

  def set_keychain
    @keychain = Keychain.where(api_token: params[:api_token], api_secret: params[:api_secret]).first
    unless @keychain
      render json: {errors: "bad request, missing keychain"}, status: :unprocessable_entity
    end
  end

  def set_user
    @user = @keychain.user
    unless @user
      render json: {errors: "bad request, missing user"}, status: :unprocessable_entity
    end
  end

  def set_tag
    @tag = Tag.where(name: user_song_tag_params[:tag].downcase).first_or_create
  end
end
