class MusicNews.Collections.Songs extends Backbone.Collection
  initialize: ->
    @deferred = @fetch()

  url: 'songs'
  model: MusicNews.Models.Song
  comparator: (song)->
    -song.get('playback_count')

