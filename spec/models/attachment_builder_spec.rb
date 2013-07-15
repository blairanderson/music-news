require 'spec_helper'

describe AttachmentBuilder do 
  let(:submission){Submission.create}
  describe '.process' do 
    let(:params) do 
      {
        :youtube=>{
          "1"=>"http://www.youtube.com/watch?v=VP7GNxLI9fM",
          "2"=>""},
        :soundcloud=>{
          "1"=>"https://soundcloud.com/juicyjmusic/bounce-it", 
          "2"=>"https://soundcloud.com/juicyjmusic/show-out-remix-ft-pimp-c-and-t"
              }, 
        :bandcamp=>{"1"=>""}
      }
    end
    it 'should accept all attachement params and create things' do 
      AttachmentBuilder.process(params, submission)
      expect(Youtube.count).to eq 1
      expect(Song.soundclouds.count).to eq 2
    end    
  end

  describe '.process_youtube' do 
    let(:youtube_params) do 
      {
        "1"=>"http://www.youtube.com/watch?v=VP7GNxLI9fM",
        "2"=>""
        }
    end
    it 'should send the url to the youtube processor' do 
      expect { AttachmentBuilder.process_youtube(youtube_params,submission) }.to change{Youtube.count}.by(1)
    end
  end

  describe '.process_soundcloud' do 
    let(:soundcloud_params) do 
      {
      "1"=>"https://soundcloud.com/juicyjmusic/bounce-it", 
      "2"=>"https://soundcloud.com/juicyjmusic/show-out-remix-ft-pimp-c-and-t"
      }
    end
    it 'should send the url to the soundcloud processor' do 
      expect { AttachmentBuilder.process_soundcloud(soundcloud_params,submission) }.to change{Song.soundclouds.count}.by(2)
    end
  end

  describe '.process_bandcamp' do 
    let(:bandcamp_params) do 
        {
          "1"=>"http://mysteryskulls.bandcamp.com/track/amazing",
          "3"=>"http://mysteryskulls.bandcamp.com/track/you",
          "2"=>"http://mysteryskulls.bandcamp.com/track/money",
          "4"=>""
        }
    end
    it 'should send the url to the soundcloud processor' do 
      expect { AttachmentBuilder.process_bandcamp(bandcamp_params,submission) }.to change{Song.bandcamps.count}.by(3)
    end
  end
end
