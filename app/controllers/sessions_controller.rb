class SessionsController < ApplicationController

  def show
    if current_user
      render json: current_user
    else
      render json: {message: "Please Sign In!", link: "/auth/twitter"}
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end  
end
