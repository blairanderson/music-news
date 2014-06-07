class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_account

  def twitter
    if @account.persisted?
      sign_in_and_redirect @account, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_account_registration_url
    end
  end

  def github
    if @account.persisted?
      sign_in_and_redirect @account, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_account_registration_url
    end
  end

  def set_account
    @account = Account.find_for_oauth(request.env["omniauth.auth"], current_account)
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end

end
