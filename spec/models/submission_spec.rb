require 'spec_helper'

describe Submission do
  describe '.attachments' do 
    let!(:submission){Submission.create!}
    let(:stuff) do 
       {
      :youtube=>{
        "1"=>"http://www.youtube.com/watch?v=VP7GNxLI9fM",
        "2"=>"http://www.youtube.com/watch?v=WT7GNxLI9fM",
        "4"=>""
        },
      :soundcloud=>{
        "1"=>"https://soundcloud.com/juicyjmusic/bounce-it", 
        "2"=>"https://soundcloud.com/juicyjmusic/show-out-remix-ft-pimp-c-and-t",
        "4"=>""
        }, 
      :bandcamp=>{
        "1"=>"http://mysteryskulls.bandcamp.com/track/amazing",
        "3"=>"http://mysteryskulls.bandcamp.com/track/you",
        "2"=>"http://mysteryskulls.bandcamp.com/track/money",
        "4"=>""}
      }.with_indifferent_access
    end

    it 'should have many attachments' do 
      expect(submission.attachments.count).to eq 0
      AttachmentBuilder.process(stuff, submission) 
      expect(submission.videos.to_a.count).to eq 2
      expect(submission.songs.to_a.count).to eq 5
      expect(submission.attachments.count).to eq 7
    end
  end
end
