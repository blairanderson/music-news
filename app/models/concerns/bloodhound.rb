require 'open-uri'

class Bloodhound
  def self.create(params)
    type = params['type']
    self.send(type, params)
  end

  def self.hypem(params)
    posturl = params[:posturl] || params["posturl"]
    self.url({url: posturl})
  end

  def self.url(params)
    doc = Nokogiri::HTML( open(params['url']) )

    links = doc.css('a').map{|e| e["href"] }
    valid_links = self.keep_valid(links)

    iframes = doc.css('iframe').map{|e| e["src"] }
    valid_iframes = self.keep_valid(iframes)

    {iframes: valid_iframes, links: valid_links}
  end

  def self.keep_valid(datum)
    regex = /^https?:\/\/(soundcloud.com|snd.sc|ift.tt|w.soundcloud.com)\/(.*)$/
    datum.compact.select do |item|
      item.match(regex)
    end
  end
end
