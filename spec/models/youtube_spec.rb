require 'spec_helper'

describe Youtube do 
  let(:video) do 
    video = Youtube.new
    video.url =  "http://www.youtube.com/watch?v=1pBF1XkShg4"
    video.submission_id = 1
    video.save
    video
  end

  describe '#parse_for_embed' do 
    it 'should pull the relevant data for the embed' do 
      expect(video.parse_for_embed).to eq "http://www.youtube.com/embed/1pBF1XkShg4"
    end
  end

  describe '#embed_url' do 
    it 'should get the url from DB or build it' do
      expect(video.embed).to eq "<iframe id='ytplayer' type='text/html' width='100%' height='600px' src='http://www.youtube.com/embed/1pBF1XkShg4?autoplay=0&origin=http://news.seainhd.com' frameborder='0'/>"
    end
  end
end
