require 'spec_helper'

describe "publishing" do 
  describe 'Show' do
    it 'should show the submission and a button to build' do
      admin = create_admin
      login_admin
      
      submission = create_submission
      visit submission_publisher_path(submission)
      expect(current_path).to eq submission_publisher_path(submission)
      expect(page).to have_content(submission.title)
    end
  end
end
