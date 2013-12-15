class MusicNews.Models.Submission extends Backbone.Model
  parse: (data) ->
    this.songs = new MusicNews.Collections.Songs()
    _this = this
    for song_data in data.songs 
      new_song = new MusicNews.Models.Song(song_data)
      MusicNews.App.collections.songs.add(new_song)
      _this.songs.add(new_song)
    data
