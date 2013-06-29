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
    it 'should fetch the band_id and track_id from the api' do 
      expect(song.parse_for_embed).to eq 


    end
  end
  describe '#embed' do 
    it 'should have an embed code or create one' do 
      expect(song.embed).to eq "<iframe style='border: 0; width: 100%; height: 120px;' src='http://bandcamp.com/EmbeddedPlayer/album=4075443173/size=medium/bgcol=333333/linkcol=ffffff/transparent=true/' seamless><a href='http://yosihorikawa.bandcamp.com/album/vapor'>Vapor by Yosi Horikawa</a></iframe>"
    end
  end
end
