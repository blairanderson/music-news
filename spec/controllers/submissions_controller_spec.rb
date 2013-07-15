require 'spec_helper'

describe SubmissionsController do 

  describe 'GET index' do 
    it 'should respond OK' do 
      submission0 = create_submission
      submission1 = create_submission(title: "second sub", body: "second body")
      get :index
      expect( response ).to be_success
      expect( response ).to render_template("index")
      expect( assigns(:submissions) ).to eq [submission1, submission0]
    end
  end

  describe 'GET more' do 
    it 'should respond OK' do
      submission0 = create_submission
      submission1 = create_submission(title: "second sub", body: "second body")
      get :more
      expect( response ).to be_success
      expect( response ).to render_template("index")
      expect( assigns(:submissions) ).to eq [submission1, submission0]
    end
  end


  describe 'GET twitter' do 
    it 'should resond OK with all submissions for a given twitter name' do
      submission = create_submission
      get :twitter, twitter: "seainhd"
      expect( response ).to be_success
      expect( assigns(:submissions) ).to eq [submission]
    end
  end


  describe 'GET feed' do
    render_views

    it "returns feed from RSS format" do
      submission = create_submission
      get :feed, format: "rss"
      expect( assigns(:submissions) ).to eq [submission]
      expect( response ).to be_success
      expect( response ).to render_template("submissions/feed")
      expect( response.content_type ).to eq("application/rss+xml")
      expect( response.body ).to have_content submission.title
    end

    it "returns feed from JSON format" do
      submission = create_submission
      get :feed, format: "json"
      expect( assigns(:submissions) ).to eq [submission]
      expect( response ).to be_success
      expect( response.content_type ).to eq("application/json")
      expect( response.body ).to have_content submission.title
    end
  end

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
      expect(Song.soundclouds.count).to eq 0
      expect(Song.bandcamps.count).to eq 0
      post :create, params
      
      expect(Submission.count).to eq 1
      expect(Youtube.count).to eq 2
      expect(Song.count).to eq 5
      expect(Song.bandcamps.count).to eq 3
      expect(Song.soundclouds.count).to eq 2
    end
  end

end
