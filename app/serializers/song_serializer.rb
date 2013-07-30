class SongSerializer < ActiveModel::Serializer
  attributes  :title,
              :source_url,
              :stream_url,
              :thumbnail_url,
              :play_count,
              :comment_count,
              :download_count,
              :playback_count,
              :favoritings_count,
              :submission,
              :song,
              :onfinish,
              :resolve

  def source_url
    object.url
  end

  def resolve
    song_url(object) + '/resolve'
  end

  def onfinish
    onfinish_song_url(object)
  end

  def song
    song_url(object)
  end

  def submission
    submission_url(object.submission)
  end

  def root
    songs_url
  end
end
