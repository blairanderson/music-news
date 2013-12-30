class MusicNews.Views.Player extends Backbone.View
  id: 'music-player'
  template: JST['shared/player']
  playlistSongTemplate: JST['shared/track']

  initialize: ->
    _this = this
    @songs = MusicNews.App.collections.songs
    @songHistory = new MusicNews.Collections.Songs
    MusicNews.App.views.submissions = []
    SC.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");
    SC.whenStreamingReady ->
      console.log 'streaming ready'
      _this.updateCurrentTrack()
      console.log( _this.currentTrack )


  render: ->
    $(@el).html(this.template())
    @playButton = this.$el.find('button[data-action="play-pause-button"]')

    this

  events:
    "click button#play" : "playSong"
    "click button#pause" : "pauseSong"
    "click button#next" : "nextSong"
    "click button#previous" : "previousSong"
    "click button#nolove" : "noloveSong"
    "click button#love" : "loveSong"
    "click button#like" : "likeSong"

  updateCurrentTrack: ->
    @currentSound = undefined
    @getCurrentTrack()
    if @currentTrack
      markup = @playlistSongTemplate(song: @currentTrack )
      $(@el).find('#playlist').html markup

  getCurrentTrack: ->
    @currentTrack ||= @songs.first()
    @currentTrack

  playSong: (e) ->
    e.preventDefault() if e
    _this = this
    @playButton.attr('id', 'pause')
    @playOptions=
      onfinish: ->
        _this.nextSong()
      onplay: ->
        songs = MusicNews.App.views.main.body.find('div.song')
        songs.removeClass "active"
        songs.find('button.pause').removeClass('pause').addClass('play');

    if @currentSound
      @currentSound.play(@playOptions) 
      
    else
      $stream_url = @currentTrack.get('stream_url')
      if $stream_url is null or undefined
        _this.advanceTrack()
        return

      SC.stream $stream_url, (sound) =>
        @currentSound = sound
        @currentSound.play(@playOptions)
      

  pauseSong: (e) ->
    e.preventDefault() if e
    _this = this
    @playButton.attr('id', 'play')

    if @currentSound
      @currentSound.pause()

  nextSong: (e) ->
    e.preventDefault() if e
    @pauseSong()
    $song = @songs.shift()
    @songHistory.unshift($song)

    if @songs.length == 0
      window.location.href = window.location.href
      return
    else
      @currentTrack = undefined
      @updateCurrentTrack()
    @playSong()

  previousSong: (e) ->
    e.preventDefault() if e
    @pauseSong()
    $song = @songHistory.shift()
    if !$song
      return
    @songs.unshift($song)
    @currentTrack = undefined
    @updateCurrentTrack()
    @playSong()

  noloveSong: (e) ->
    e.preventDefault() if e
    $button = $(e.currentTarget)
    # do stuff
    $button.attr("id", "love")
    console.log("no love button")
    
  loveSong: (e) ->
    e.preventDefault() if e
    $button = $(e.currentTarget)
    # do stuff
    $button.attr("id", "like")
    console.log("love button")

  likeSong: (e) ->
    e.preventDefault() if e
    $button = $(e.currentTarget)
    # do stuff
    $button.attr("id", "nolove")
    console.log("like button")