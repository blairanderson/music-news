require 'spec_helper'

describe Tag do
  describe 'associations' do
    it { should have_many(:user_song_tags).dependent(:destroy) }
    it { should have_many(:songs).through(:user_song_tags) }
    it { should have_many(:users).through(:user_song_tags) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
