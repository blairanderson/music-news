require 'spec_helper'

describe Bandcamp do 
  let(:song) do 
    song = Bandcamp.new
    song.url =  "http://mysteryskulls.bandcamp.com/track/you"
    song.submission_id = 1
    song.save
    song
  end
end
