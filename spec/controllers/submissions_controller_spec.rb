require 'spec_helper'

describe SubmissionsController do 
  describe 'POST create' do 
    let(:params) do 
      {"submission"=>{
        "title"=>"juicy J",
        "twitter"=>"seainhd",
        "email"=>"blair@seainhd.com",
        "body"=>"Jordan Michael Houston (born April 5, 1975), better known by his stage name Juicy J, is an American rapper."},
        "youtube"=>{
          "1"=>"http://www.youtube.com/watch?v=VP7GNxLI9fM",
          "2"=>"http://www.youtube.com/watch?v=WT7GNxLI9fM",
          "4"=>""
          },
        "soundcloud"=>{
          "1"=>"https://soundcloud.com/juicyjmusic/bounce-it", 
          "2"=>"https://soundcloud.com/juicyjmusic/show-out-remix-ft-pimp-c-and-t",
          "4"=>""
          }, 
        "bandcamp"=>{
          "1"=>"http://mysteryskulls.bandcamp.com/track/amazing",
          "3"=>"http://mysteryskulls.bandcamp.com/track/you",
          "2"=>"http://mysteryskulls.bandcamp.com/track/money",
          "4"=>""}
      }

    end
    it 'should create a submission with attachments' do 
      post :create, params
      expect(Submission.count).to eq 1
      expect(Youtube.count).to eq 2
      expect(Soundcloud.count).to eq 2
      expect(Bandcamp.count).to eq 3
    end
  end

end
