require 'spec_helper'

describe Submission do
  describe '.attachments' do 
    let!(:subject){create_submission}
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
        }
      }.with_indifferent_access
    end
    before :each do 
      expect(subject.title).to eq "Valid Band Title"
      expect(subject.body).to eq "Valid Band Bio"
    end

    it 'should have many attachments' do 
      expect(subject.attachments.count).to eq 0
      AttachmentBuilder.process(stuff, subject) 
      expect(subject.videos.to_a.count).to eq 2
      expect(subject.songs.to_a.count).to eq 2
      expect(subject.attachments.count).to eq 4
    end
  end

  describe '#purge_count' do
    let!(:subject){create_submission}
    before do
      expect(subject).to be_valid
      expect(subject.songs).to be_valid
    end
  end
end
