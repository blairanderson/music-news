class MusicNews.Views.Player extends Backbone.View
  id: 'music-player'
  template: JST['shared/player']
  playlistSongTemplate: JST['shared/track']

  initialize: ->
    _this = this
    @songs = MusicNews.App.collections.songs
    @songHistory = new MusicNews.Collections.Songs
    # SC.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");
    # SC.whenStreamingReady ->
    #   console.log 'streaming ready'
    #   _this.updateCurrentTrack()
    #   console.log( _this.currentTrack )


  render: ->
    $(@el).html(this.template())
    @playButton = this.$el.find('button[data-action="play-pause-button"]')

    this

  events:
    "click div#player button" : "buttonHandler"

  buttonHandler: (e)->
    e.preventDefault();
    $button = $(e.currentTarget)
    $action = $button.attr('id')
    @buttonAction[$action](this)


  updateCurrentTrack: ->
    @currentSound = undefined
    @getCurrentTrack()
    if @currentTrack
      markup = @playlistSongTemplate(song: @currentTrack )
      $(@el).find('#playlist').html markup


  getCurrentTrack: ->
    @currentTrack ||= @songs.first()
    @currentTrack

  playSong: ->
    _this = this
    @playButton.attr('id', 'pause')

    if @currentSound
      @currentSound.play()
    else
      $stream_url = @currentTrack.get('stream_url')
      if $stream_url is null or undefined
        _this.advanceTrack()
        return

      SC.stream $stream_url, (sound) =>
        @currentSound = sound
        @currentSound.play()

  pauseSong: ->
    _this = this
    @playButton.attr('id', 'play')

    if @currentSound
      @currentSound.pause()

  advanceTrack: ->
    $song = @songs.shift()
    @songHistory.unshift($song)

    if @songs.length == 0
      window.location.href = window.location.href
      return
    else
      @updateCurrentTrack()

  previousTrack: ->
    $song = @songHistory.shift()
    if !$song
      return
    @songs.unshift($song)
    @updateCurrentTrack()

  stopSong: ->
    this.currentSound.unload()
    this.currentSound = undefined

  buttonAction:
    "play": (player)->
      player.playSong()
      console.log('play button action')

    "pause": (player)->
      player.pauseSong()
      console.log('pause button action')

    "next": (player)->
      this.pause(player)
      player.advanceTrack()
      this.play(player)

      console.log("next button action")

    "previous": (player)->
      this.pause(player)
      player.previousTrack()
      this.play(player)

      console.log("previous button action")

    "love": (player)->
      console.log("love button action")

    "like": (player)->
      console.log("like button action")