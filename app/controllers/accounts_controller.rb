class AccountsController < ApplicationController

  before_action :set_account, :finish_signup

  def finish_signup
    if request.patch? && params[:account] #&& params[:user][:email]
      if current_account.update(account_params)
        current_account.skip_reconfirmation!
        sign_in(current_account, :bypass => true)
        redirect_to current_account, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    accessible = [ :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:account][:password].blank?
    params.require(:account).permit(accessible)
  end

end
