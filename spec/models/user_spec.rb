require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:user_song_tags).dependent(:destroy) }
    it { should have_many(:songs).through(:user_song_tags) }
  end
end
