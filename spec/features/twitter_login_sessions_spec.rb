require 'spec_helper'

describe "twitter auth and sessions" do 
  OmniAuth.config.test_mode = true

  auth_credentials = {
      'uid' => '14828267',
      'provider' => 'twitter',
      'info' => {
        'name' => 'Blair Anderson'
      },
      'credentials' => {
        'secret' => "asdfghjkl",
        'token' => "lkjhgfdsa"
      }
    }
  OmniAuth.config.mock_auth[:twitter] = OpenStruct.new(auth_credentials)

  describe "creating an account" do 
    it 'should create an account' do 
      visit "/auth/twitter"
      expect(User.count).to eq 1
    end

    it 'should find the created user' do 
      User.create!(provider: "twitter", uid: '14828267')
      visit '/auth/twitter'
      expect( page ).to have_content "Sign Out"
    end
  end
end
