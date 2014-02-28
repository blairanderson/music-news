require 'spec_helper'

describe Publisher do

  let(:submission) {create_submission}
  let(:song) {create_song(submission_id: submission.id)}

  before :each do
    VCR.use_cassette("oembed/yuniintaxco/echoes") do
      song.resolve
      expect(song.thumbnail_url).to eq "http://i1.sndcdn.com/artworks-000022810909-5axxr4-t500x500.jpg?d53bf9f"
      expect(song.title).to eq "Echoes by Yuni in Taxco"
      expect(song.active).to eq "true"
      expect(song.embed).to eq "<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F45368100&show_artwork=true&client_id=c024bdd48e9ecf014c71af406201f3a2\"></iframe>"
    end
  end

  describe '.build_article' do
    it 'should create a thing that is ready to be published' do
      # article = Publisher.build_article(submission)
      # expect(article.title).to eq "Listen: Some Music from @seainhd"
      # expect(article.body).to eq "<h2>Echoes by Yuni in Taxco</h2>\n<br>\n<iframe width=\"100%\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F45368100&show_artwork=true&client_id=c024bdd48e9ecf014c71af406201f3a2\"></iframe>\n<br>\n<img width=\"100%\" src=\"http://i1.sndcdn.com/artworks-000022810909-5axxr4-t500x500.jpg?d53bf9f\">\n<br>\n"
    end
  end
end
