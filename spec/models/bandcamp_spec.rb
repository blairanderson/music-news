require 'spec_helper'

describe Bandcamp do 
  let(:song) do 
    song = Bandcamp.new
    song.url =  "http://mysteryskulls.bandcamp.com/track/you"
    song.submission_id = 1
    song.save
    song
  end
  describe '#parse_for_embed' do 
    it 'should fetch the band_id and track_id from the api' 
  end
  describe '#embed' do 
    it 'should have an embed code or create one'
  end
end
