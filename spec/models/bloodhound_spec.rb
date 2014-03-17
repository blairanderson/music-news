require 'spec_helper'

describe Bloodhound do
  describe '.keep_valid' do
    let(:valid_urls) do
      [
        "http://ift.tt/NQSp4K",
        "https://soundcloud.com/dabinlee/ghost-hack",
        "http://snd.sc/1cvgIjv",
        "https://w.soundcloud.com/player/?visual=true&url=http://api.soundcloud.com/tracks/137879475&show_artwork=true",
        "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/137879475&amp;auto_play=false&amp;hide_related=false&amp;visual=true"
      ]
    end

    it 'should keep all valid urls' do
      valid_url_count = valid_urls.length

      urls = Bloodhound.keep_valid(valid_urls)

      expect(urls.length).to eq valid_url_count
    end


    let(:invalid_urls) do
      [
        'http://google.com',
        'facebook.farts',
        'i can has cheezburgers',
        'http://waffletaco.com',
        'http://soundclord.com',
        'http://soundcloud.corm',
        'httz://soundcloud.com'
      ]
    end

    it 'should reject all invalid urls' do
      urls = Bloodhound.keep_valid(invalid_urls)
      expect(urls.length).to eq 0
    end
  end

  describe '.hypem' do
    let(:hypem_favorite) do
      {
        mediaid: "233pg",
        artist: "Duck Sauce",
        title: "NRG (Skrillex, Kill The Noise, Milo & Otis Remix)",
        dateposted: 1394948585,
        siteid: 16492,
        sitename: "Earbuddy",
        posturl: "http://www.earbuddy.net/43703/tame-impala-jay-electronica-skrillex.html/columns/sunday-leftovers",
        postid: 2426908,
        loved_count: 674,
        posted_count: 6,
        description: "When the Singles Buffet is so full, there’s bound to be leftovers. Enjoy some of the leftovers with new music",
      }
    end

    it 'should parse the url and pass it to the url handler' do
      Bloodhound.should_receive(:url).with({url: hypem_favorite[:posturl]})
      Bloodhound.hypem(hypem_favorite)
    end
  end
end
