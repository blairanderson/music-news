require 'spec_helper'


describe UserSongTagsController do
  # describe 'POST #create' do
  #   let(:valid_user) { FactoryGirl.create(:user) }
  #   let(:valid_song) { FactoryGirl.create(:song) }
  #   let(:valid_data) do
  #     {
  #       "api_token"=> valid_user.keychain.api_token,
  #       "api_secret"=> valid_user.keychain.api_secret,
  #       "user_song_tag"=>{"tag"=>"love", "song_id"=>valid_song.id}
  #     }
  #   end
  #   context 'happy path' do
  #     it 'creates a tag if one does not exist' do
  #       expect(Tag.count).to eq 0
  #
  #       expect{
  #         post :create, valid_data
  #       }.to change(Tag, :count).by(1)
  #     end
  #
  #     it 'does not create duplicate records' do
  #       tag = Tag.create(name: "love")
  #       target = UserSongTag.create(user_id: valid_user.id, song_id: valid_song.id, tag_id: tag.id)
  #       expect(UserSongTag.count).to eq 1
  #
  #       post :create, valid_data
  #       expect(UserSongTag.count).to eq 1
  #       expect(response.status).to eq 200
  #       expect( assigns(:favorite) ).to eq target
  #     end
  #
  #     it 'joins an existing user, existing song, and existing tag' do
  #       expect{
  #         post :create, valid_data
  #       }.to change(UserSongTag, :count).by(1)
  #     end
  #
  #     it 'assigns a user' do
  #       post :create, valid_data
  #       expect( assigns(:user) ).to be_valid
  #     end
  #     it 'assigns a tag' do
  #       post :create, valid_data
  #       expect( assigns(:tag) ).to be_valid
  #     end
  #   end
  #
  #   context 'when a song does not exist' do
  #     shared_examples_for 'an invalid song' do |invalid_song_id|
  #       let(:valid_missing_song) do
  #         {"api_token"=> valid_user.keychain.api_token,
  #          "api_secret"=> valid_user.keychain.api_secret,
  #          "user_song_tag"=>{"tag"=>"love", "song_id"=>invalid_song_id}}
  #       end
  #       it "#{invalid_song_id} is not valid" do
  #         expect{
  #           post :create, valid_missing_song
  #         }.to_not change(UserSongTag, :count).by(1)
  #       end
  #     end
  #
  #     it_behaves_like 'an invalid song', 'taco'
  #     it_behaves_like 'an invalid song', nil
  #
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   it 'removes the item'
  # end
  #
  # describe 'GET #index' do
  #   it 'requires a keychain' do
  #     get :index
  #     expect(response.status).to eq 422
  #
  #     body = JSON.parse(response.body)
  #     expect(body.keys).to include 'errors'
  #     expect(body.values).to include 'bad request, missing keychain'
  #   end
  #
  #   let(:keychain) { FactoryGirl.create(:keychain) }
  #   it 'requires a user' do
  #     get :index, keychain.attributes.slice('api_token', 'api_secret')
  #     expect(response.status).to eq 422
  #
  #     body = JSON.parse(response.body)
  #     expect(body.keys).to include 'errors'
  #     expect(body.values).to include 'bad request, missing user'
  #   end
  #
  #
  #   it 'lists all favorites for a given user' do
  #     user = FactoryGirl.create(:user)
  #     song = FactoryGirl.create(:song)
  #     tag =  FactoryGirl.create(:tag)
  #     user_song_tag = FactoryGirl.create(:user_song_tag, user: user, song: song, tag: tag)
  #
  #     User.any_instance.should_receive(:songs)
  #     get :index, user.keychain.attributes.slice('api_token', 'api_secret')
  #     expect(response.status).to eq 200
  #   end
  # end
end
