class SongSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object
  
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
              :resolve

  def source_url
    object.url
  end

  def resolve
    song_url(object) + '/resolve'
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
