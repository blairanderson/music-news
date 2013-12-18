class MusicNews.Views.Player extends Backbone.View
  id: 'music-player'
  template: JST['shared/player']
  playlistSongTemplate: JST['shared/track']

  initialize: ->
    _this = this
    @songs = MusicNews.App.collections.songs
    @songHistory = new MusicNews.Collections.Songs
    SC.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");
    SC.whenStreamingReady ->
      console.log 'streaming ready'
      _this.updateCurrentTrack()

  render: ->
    $(@el).html(this.template())
    this

  events: 
    "click div#player button" : "buttonHandler"

  buttonHandler: (e)->
    e.preventDefault();
    $button = $(e.currentTarget)
    $action = $button.attr('id')
    @buttonAction[$action](this, $button)


  updateCurrentTrack: ->
    @getCurrentTrack()
    if @currentTrack
      $(@el).find('#playlist i.track').text("  now playing....")
      markup = @playlistSongTemplate(song: @currentTrack )
      $(@el).find('#playlist .body ul').prepend markup


  getCurrentTrack: ->
    @currentTrack = @songs.first()
    @currentTrack

  playSong: (song)->
    _this = this
    if @currentSound
      @currentSound.play()
    else
      debugger
      $stream_url = _this.currentTrack.get('stream_url')
      SC.stream $stream_url, (sound) => 
        _this.currentSound = sound
        _this.currentSound.play()

  pauseSong: (song)->
    _this = this
    if @currentSound
      @currentSound.pause()

  advanceTrack: ->
    this.currentSound.unload()
    this.currentSound = undefined
    @songHistory.add(@currentTrack)
    @songs.remove(@currentTrack)
    @updateCurrentTrack
    @playSong

  buttonAction:
    "play": (player, button)->
      $song = player.currentTrack
      player.playSong($song)
      button.attr('id', 'pause')
      console.log('play button action')

    "pause": (player, button)->
      $song = player.currentTrack
      player.pauseSong($song)
      button.attr('id', 'play')
      console.log('pause button action')

    "next": (player, button)->
      player.advanceTrack()
      console.log("next button action")

    "previous": (player, button)->
      console.log("previous button action")

    "love": (player, button)->
      console.log("love button action")

    "like": (player, button)->
      console.log("like button action")