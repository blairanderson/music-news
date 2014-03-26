require 'spec_helper'

describe SubmissionsController do

  describe 'GET show' do
    before do
      Song.any_instance.stub(:resolve)
      @submission = create_submission
      get :show, id: @submission.id
    end

    it 'should respond OK' do
      expect( response ).to be_ok
    end

    it 'should respond with JSON' do
      expect( JSON.parse(response.body)['id'] ).to eq @submission.id
    end
  end

  describe 'GET index' do
    it 'should respond OK' do
      submission0 = create_submission
      submission1 = create_submission(title: "second sub", body: "second body")
      get :index
      expect( response ).to be_success
      expect( response.content_type ).to eq("application/json")
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
