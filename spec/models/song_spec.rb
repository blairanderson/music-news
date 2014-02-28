require 'spec_helper'

describe Song do
  describe 'validations' do
    it { should allow_value("https://soundcloud.com/yuniintaxco/echoes").for(:url) }
    it { should allow_value("https://soundcloud.com/franklin-webber/golden-streets").for(:url) }
    it { should allow_value("https://soundcloud.com/band-d-ga-df-sdfasdf-dasfasdf/echoes").for(:url) }
    it { should_not allow_value("").for(:url) }
    it { should_not allow_value(" | "," | | ").for(:url) }
    it { should_not allow_value("http://youtube.com/").for(:url) }
    it { should_not allow_value("soundcloud.com/asdlkfjasdflkja/sometasdflkjasdf").for(:url) }
    it { should_not allow_value("sometbullshit/sometasdflkjasdf").for(:url) }
  end
end
