class UserSongTagsController < ApplicationController
  before_action :set_user
  before_action :set_tag

  def create
    @favorite = UserSongTag.new(valid_favorite)

    if @favorite.save
      render json: @favorite
    else
      head :unprocessable_entity,  json: {errors: @favorite.errors.full_messages }
    end
  end

  def destroy
  end

private

  def valid_favorite
    user_song_tag_params.slice(:song_id).merge({user_id: @user.id,tag_id: @tag.id})
  end

  def user_song_tag_params
    params.require(:user_song_tag).permit(:song_id, :tag)
  end

  def set_user
    keychain = Keychain.where(api_token: params[:api_token], api_secret: params[:api_secret]).first
    user = keychain.user
    if user
      @user = user
    else
      head :unprocessable_entity, json: {errors: "bad request"}
    end
  end

  def set_tag
    @tag = Tag.where(name: user_song_tag_params[:tag].downcase).first_or_create
  end
end
