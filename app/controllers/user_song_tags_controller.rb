class UserSongTagsController < ApplicationController
  before_action :set_user

  def create
    binding.pry
    user = User.where
  end

  def destroy
  end

private
  def set_user
    @user = User.where()
  end
  def user_song_tag_params
    require(:user_song_tag).permit(:song_id, :tag)
  end
end
