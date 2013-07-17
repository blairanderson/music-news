require 'spec_helper'

describe Song do
  describe 'validations' do 
    valid_songs = [
      "https://soundcloud.com/yuniintaxco/echoes",
      "https://soundcloud.com/franklin-webber/golden-streets",
      "https://soundcloud.com/band-d-ga-df-sdfasdf-dasfasdf/echoes"
    ]

    valid_songs.each do |song_url|
      it "#{song_url} should be valid" do 
        song = create_song(url: song_url)
        expect(song.url).to eq song_url
        expect(song).to be_valid
      end
    end

    invalid_songs = [
      "",
      " | ",
      " | | ",
      "http://youtube.com/",
      "sometbullshit/sometasdflkjasdf",
      "https://soundcloud.com/",
      "soundcloud.com/asdlkfjasdflkja/sometasdflkjasdf",
      ]
    invalid_songs.each do |song_url|
      it "should be invalid: #{song_url}" do 
        song = Song.new(url: song_url)

        expect( song.url ).to eq song_url
        
        expect( song ).to be_invalid
      end
    end
  end

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
