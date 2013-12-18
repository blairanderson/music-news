class MusicNews.Models.Submission extends Backbone.Model
  defaultThumbnail: ->
    "http://placehold.it/300x300"
  parse: (data) ->
    this.songs = new MusicNews.Collections.Songs()
    _this = this
    for song_data in data.songs 
      new_song = new MusicNews.Models.Song(song_data)
      MusicNews.App.collections.songs.add(new_song)
      _this.songs.add(new_song)

    firstSong = this.songs.models[0]
    if firstSong && firstSong.get('thumbnail_url')
      this.thumbnail_url = firstSong.get('thumbnail_url')
    else
      this.thumbnail_url = this.defaultThumbnail()
    data
