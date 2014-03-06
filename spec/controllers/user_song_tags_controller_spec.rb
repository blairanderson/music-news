require 'spec_helper'


describe UserSongTagsController do
  describe '#POST create' do
    context 'happy path' do
      it 'joins an existing user, existing song, and existing tag'
      it 'creates a tag if one does not exist'
      it 'does not create duplicate records'
    end

    context 'when a song does not exist' do
      it 'is not successful'
    end
  end

  describe '#DELETE destroy' do
    it 'removes the item'
  end
end
