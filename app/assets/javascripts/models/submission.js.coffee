class MusicNews.Models.Submission extends Backbone.Model
  url: ->
    "/s/#{this.id}/resolve"
  defaultThumbnail: ->
    "http://placehold.it/300x300"
  parse: (data) ->
    @url = window.location.href
    @parseDates(data)
    @parseTweet(data)
    @parseShare(data)
    @songs = new MusicNews.Collections.Songs()
    _this = this
    for song_data in data.songs 
      new_song = new MusicNews.Models.Song(song_data)
      new_song.set("submission_url", "#{window.location.origin}/#{new_song.get('submission_id')}")
      _this.songs.add(new_song)
    firstSong = @songs.models[0]
    if firstSong && firstSong.get('thumbnail_url')
      data.thumbnail_url = firstSong.get('thumbnail_url')
    else
      data.thumbnail_url = this.defaultThumbnail()
      
    data

  parseDates:(data) ->
    date = moment(data.created_at)
    data.fromNow = date.fromNow()
    data.calendar = date.calendar()
  parseShare:(data)->
    base = "http://www.facebook.com/sharer/sharer.php?"
    _this = this
    potentialShare = 
      u:  _this.url
    data.share = base + $.param potentialShare

  parseTweet:(data) ->
    base = "https://twitter.com/intent/tweet?"
    potentialTweet = 
      text: "@#{data.twitter} I love these songs! "
      url: window.location.href
      via: 'seainhd'
      hashtags: '#newMusicNews'
    data.tweet = base + $.param potentialTweet