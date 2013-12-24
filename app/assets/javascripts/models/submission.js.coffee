class MusicNews.Models.Submission extends Backbone.Model
  url: ->
    "/s/#{this.id}/resolve"
  defaultThumbnail: ->
    "http://placehold.it/300x300"
  parse: (data) ->
    @songs = new MusicNews.Collections.Songs()
    _this = this
    for song_data in data.songs 
      new_song = new MusicNews.Models.Song(song_data)
      new_song.set("submission_url", "#{window.location.origin}/#{new_song.get('submission_id')}")
      MusicNews.App.collections.songs.add(new_song)
      _this.songs.add(new_song)
    firstSong = @songs.models[0]
    if firstSong && firstSong.get('thumbnail_url')
      this.thumbnail_url = firstSong.get('thumbnail_url')
    else
      this.thumbnail_url = this.defaultThumbnail()
    data
