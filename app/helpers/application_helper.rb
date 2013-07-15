module ApplicationHelper

  def site_title
    "SEAinHD"
  end

  def twitter_link(submission, options = {})
    link_to "twitter @#{submission.twitter}", "https://twitter.com/#{submission.twitter}", options
  end
end
