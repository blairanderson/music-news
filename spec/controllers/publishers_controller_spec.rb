require 'spec_helper'

describe PublishersController do
  context 'authorized admin' do 
    describe "GET new" do
      it 'should be success' do
        submission = create_submission 
        admin = create_admin
        request.session[:user_id] = admin.id
        get :new, submission_id: submission.id
        expect(response.status).to eq 200
        expect(response).to render_template(:new)
        expect( assigns(:submission) ).to eq submission
      end
    end

    describe "POST create" do
      it 'should be success' do
        submission = create_submission 
        admin = create_admin
        request.session[:user_id] = admin.id
        get :new, submission_id: submission.id
        expect(response.status).to eq 200
        expect(response).to render_template(:new)
        expect( assigns(:submission) ).to eq submission
      end
    end
  end

  context "unauthorized user" do 
    describe 'GET new' do 
      it 'should redirect user to root' do 
        user = create_user
        request.session[:user_id] = user.id
        get :new
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST create' do 
      it 'should redirect user to root' do 
        user = create_user
        request.session[:user_id] = user.id
        post :create
        expect(response.status).to eq 302
        expect(response).to redirect_to(root_path)
      end
    end
    
  end
end
