module ApplicationHelper

  def site_title
    "Wake and Shake"
  end

  def twitter_link(submission, options = {})
    link_to "twitter @#{submission.twitter}", "https://twitter.com/#{submission.twitter}", options
  end
end
