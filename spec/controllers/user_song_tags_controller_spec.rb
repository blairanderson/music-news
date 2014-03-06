require 'spec_helper'


describe UserSongTagsController do
  describe '#POST create' do
    let(:valid_user) { FactoryGirl.create(:user) }
    let(:valid_song) { FactoryGirl.create(:song) }
    let(:valid_data) do
      {
        "api_token"=> valid_user.keychain.api_token,
        "api_secret"=> valid_user.keychain.api_secret,
        "user_song_tag"=>{"tag"=>"love", "song_id"=>valid_song.id}
      }
    end
    context 'happy path' do
      it 'creates a tag if one does not exist' do
        expect(Tag.count).to eq 0

        expect{
          post :create, valid_data
        }.to change(Tag, :count).by(1)
      end

      it 'does not create duplicate records' do
        expect(UserSongTag.count).to eq 0
        post :create, valid_data
        expect(UserSongTag.count).to eq 1

        post :create, valid_data
        expect(response.status).to eq 422
        expect( assigns(:favorite).errors.messages[:user_id] ).to include "user song tag already exists"
      end

      it 'joins an existing user, existing song, and existing tag' do
        expect{
          post :create, valid_data
        }.to change(UserSongTag, :count).by(1)
      end
    end

    context 'when a song does not exist' do
      it 'is not successful'
    end
  end

  describe '#DELETE destroy' do
    it 'removes the item'
  end
end
