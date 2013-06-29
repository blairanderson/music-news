module Attachment

  module ClassMethods
    def process(url, submission)
      unless url.empty?
        item = new
        item.url = url
        item.submission_id = submission.id
        item.save
      end
    end
  end

  
  def self.included(base)
    base.extend(ClassMethods)
  end
end
