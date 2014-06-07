require 'spec_helper'

describe SubmissionsController do
  before do
    Song.any_instance.stub(:resolve)
  end

  describe 'GET show' do
    it 'should respond OK' do
      submission = create_submission(twitter: "taco", email: "email@eamil.com")
      get :show, id: submission.id
      expect( response ).to be_ok
      expect( response ).to render_template :show
    end
  end

  describe 'GET index' do
    it 'should respond OK' do
      submission0 = create_submission(twitter: "taco", email: "email@eamil.com")
      submission1 = create_submission(title: "second sub", body: "second body", twitter: "taco2", email: "email@eamil.com")
      get :index
      expect( response ).to be_success
      expect( response ).to render_template :index
      expect( assigns(:submissions) ).to eq [submission1, submission0]
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      let(:params) do
        {"submission"=> {"title"=>"Best Band EVAARRR",
         "body"=>"this is my bio",
         "twitter"=>"wat",
         "email"=>"blair@quickleft.com",
         "songs_attributes"=>
          {"0"=>{"url"=>"https://soundcloud.com/furns/sparks"},
           "1"=>{"url"=>"http://google.com"},
           "2"=>{"url"=>""}}}
         }
      end
      it 'should create a submission with attachments' do
        Song.any_instance.should_receive(:resolve)
        expect(Song.count).to eq 0
        expect(Submission.count).to eq 0
        post :create, params
        target = assigns(:submission)

        expect(response).to redirect_to root_path

        expect(Submission.count).to eq 1
        expect(Song.count).to eq 1
      end
    end

    describe "without any valid songs" do
      let(:params) do
        {"submission"=> {"title"=>"Best Band EVAARRR",
         "body"=>"this is my bio",
         "twitter"=>"wat",
         "email"=>"blair@quickleft.com",
         "songs_attributes"=>
          {"0"=>{"url"=>"https://soundcloud.com/furns"},
           "1"=>{"url"=>"http://google.com"},
           "2"=>{"url"=>"http://foo"}}}
         }
      end
      it 'should create a submission with attachments' do
        expect(Song.count).to eq 0
        expect(Submission.count).to eq 0
        post :create, params
        target = assigns(:submission)

        expect(response).to render_template :new

        expect(target.errors).to include(:songs)
        expect(target.errors[:songs]).to include("Must Have At Least 1 Song")

        expect(Submission.count).to eq 0
        expect(Song.count).to eq 0
      end
    end
  end

end
