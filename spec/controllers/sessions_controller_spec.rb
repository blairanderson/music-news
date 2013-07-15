require 'spec_helper'

describe SessionsController do
  let(:user) {create_user}

  describe "GET destroy" do 
    it 'should nil the session and redirect to root' do 
      get :destroy
      expect(response.status).to eq(302)
      expect(session[:user_id]).to be_nil
    end
  end
end
