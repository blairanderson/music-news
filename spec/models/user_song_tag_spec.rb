require 'spec_helper'

describe UserSongTag do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:song) }
    it { should belong_to(:tag) }
  end

  describe 'validations' do
    it { should validate_presence_of     :user_id }
    it { should validate_numericality_of :user_id }

    it { should validate_presence_of     :song_id }
    it { should validate_numericality_of :song_id }

    it { should validate_presence_of     :tag_id }
    it { should validate_numericality_of :tag_id }

    it { should validate_uniqueness_of(:user_id).scoped_to([:tag_id, :song_id]) }
  end
end
