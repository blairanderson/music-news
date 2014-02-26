class MusicNews.Models.Submission extends Backbone.Model

  url: ->
    "/submissions/#{@id}"

  initialize: (options) ->
    if options.fetch
      @deferred = @fetch()

  defaultThumbnail: ->
    "http://placehold.it/300x300"

  parseDate:(date) ->
    moment(date)

  fromNow: ->
    @parseDate( @get 'created_at' ).fromNow()

  calendar: ->
    @parseDate( @get 'created_at' ).calendar()

  parse: (data) ->
    @songs = new MusicNews.Collections.Songs()
    for song_data in data.songs 
      new_song = new MusicNews.Models.Song(song_data)
      @songs.add(new_song)
      MusicNews.collections.latest_songs.add(new_song)
      
    firstSong = @songs.models[0]
    if firstSong && firstSong.get('thumbnail_url')
      data.thumbnail_url = firstSong.get('thumbnail_url')
    else
      data.thumbnail_url = @defaultThumbnail()
    data

  facebookShare:(data)->
    base = "http://www.facebook.com/sharer/sharer.php?"
    _this = this
    potentialShare = 
      u:  _this.url
    data.share = base + $.param potentialShare

  twitterShare:(data) ->
    base = "https://twitter.com/intent/tweet?"
    potentialTweet = 
      text: "@#{data.twitter} I love these songs! "
      url: window.location.href
      via: 'seainhd'
      hashtags: '#newMusicNews'
    data.tweet = base + $.param potentialTweet