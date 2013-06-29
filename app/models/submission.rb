class Submission < ActiveRecord::Base


  def songs
    Song.where(submission_id: self.id)
  end

  def videos
    Video.where(submission_id: self.id)
  end

  def attachments
    songs.concat(videos)
  end

end
