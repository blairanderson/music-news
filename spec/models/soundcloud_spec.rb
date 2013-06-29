require 'spec_helper'

describe Soundcloud do 
  let(:song) do 
    song = Soundcloud.new
    song.url =  "https://soundcloud.com/mysteryskulls/ghost-2012"
    song.submission_id = 1
    song.save
    song
  end
  describe '#embed' do 
    it 'should have embed url or create it' do 
      expect(song.embed).to eq "<iframe id='sc-widget' width='100%' height='166' scrolling='no' frameborder='no' src='https://w.soundcloud.com/player/?url=https://soundcloud.com/mysteryskulls/ghost-2012&show_artwork=true'></iframe>"
    end
  end
end
