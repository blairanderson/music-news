require 'spec_helper'

describe Soundcloud do 
  let(:song) do 
    song = Soundcloud.new
    song.url =  "https://soundcloud.com/mysteryskulls/ghost-2012"
    song.submission_id = 1
    song.save
    song
  end
end
