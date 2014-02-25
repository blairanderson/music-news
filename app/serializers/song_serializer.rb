class SongSerializer < ActiveModel::Serializer
  # cached
  # delegate :cache_key, to: :object
  attributes  :id,
              :uri,
              :type,
              :root,
              :title,
              :active,
              :resolve,
              :play_count,
              :submission_uri,
              :source_url,
              :stream_url,
              :thumbnail_url,
              :submission_id,
              :comment_count,
              :download_count,
              :playback_count,
              :favoritings_count,
              :updated_at,
              :created_at

  def source_url
    object.url
  end

  def resolve
    song_url(object) + '/resolve'
  end

  def uri
    song_url(object)
  end

  def submission_uri
    submission_url(object.submission)
  end

  def root
    songs_url
  end
end
