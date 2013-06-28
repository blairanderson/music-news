require 'spec_helper'

describe SubmissionsController do 
  describe 'POST create' do 
    let(:params) do 
      {"submission"=>{
        "title"=>"juicy J",
        "body"=>"Jordan Michael Houston (born April 5, 1975), better known by his stage name Juicy J, is an American rapper, record producer and Academy Award-winning songwriter. He is a member of the duo Three 6 Mafia and is currently signed to Taylor Gang Records. He has released two solo studio albums with a third, Stay Trippy coming in the summer of 2013."},
        "youtube"=>{
          "1"=>"http://www.youtube.com/watch?v=VP7GNxLI9fM"
          },
        "soundcloud"=>{
          "1"=>"https://soundcloud.com/juicyjmusic/bounce-it", 
          "2"=>"https://soundcloud.com/juicyjmusic/show-out-remix-ft-pimp-c-and-t"
          }, 
        "bandcamp"=>{"1"=>""}, "commit"=>"Create Submission"}
    end
    it 'should create a submission with attachments' do 
      post :create, params
      expect(Submission.count).to eq 1
      expect(Youtube.count).to eq 1
      # expect(Soundcloud.count).to eq 2
    end
  end

end
