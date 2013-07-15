require 'spec_helper'

describe Song do
  describe '#resolve' do 
    it 'should get information from the API' do
      VCR.use_cassette("oembed/yuniintaxco/echoes") do 
        song = Song.create!(
          type: "Soundcloud", 
          url: "https://soundcloud.com/yuniintaxco/echoes")
        song.resolve
        expect(song.thumbnail_url).to eq "http://i1.sndcdn.com/artworks-000022810909-5axxr4-t500x500.jpg?cc07a88"
        expect(song.title).to eq "Echoes by Yuni in Taxco"
        expect(song.active).to eq "true"
        expect(song.embed).to eq "<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F45368100&show_artwork=true&client_id=c024bdd48e9ecf014c71af406201f3a2\"></iframe>"
      end
    end
  end
end
