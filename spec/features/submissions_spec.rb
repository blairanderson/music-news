require 'spec_helper'

describe Submission do
  describe '/new' do
    it 'lets a user submit their band title and multiple songs' do
      Song.any_instance.stub(:resolve)
      visit new_submission_path
      fill_in 'submission_title', with: "Valid Band Title"
      fill_in 'submission_email', with: "band@example.com"
      fill_in 'submission_twitter', with: "seainhd"
      fill_in 'submission_body', with: "Valid Band Body"
      fill_in 'submission[songs_attributes][0][url]', with: "https://soundcloud.com/juicyjmusic/bounce-it"
      fill_in 'submission[songs_attributes][1][url]', with: "https://soundcloud.com/juicyjmusic/bounce-it2"
      fill_in 'submission[songs_attributes][2][url]', with: "https://soundcloud.com/juicyjmusic/bounce-it3"
      click_on "Submit!"
      expect(Submission.count).to eq 1
      expect(Song.count).to eq 3
      target = Song.first
      expect(target.url).to eq "https://soundcloud.com/juicyjmusic/bounce-it"
    end
  end
end
