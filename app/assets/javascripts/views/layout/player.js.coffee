class MusicNews.Player extends Backbone.View
  id: 'music-player'

  className: 'container'

  template: JST['shared/player']

  playlistSongTemplate: JST['shared/track']

  initialize: ->
    SC.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");
    SC.whenStreamingReady =>
      @render()
      console.log 'streaming ready'


  render: ->
    @$el.html @template()
    @playButton = @$el.find('button[data-action="play-pause-button"]')
    this

  events:
    "click button#play" : "playSong"
    # TODO: update currentPlaylist
    # TODO: change the currentTrack
    # TODO:     @on 'change' event should re-render views:
    # TODO:       player: status of relationship between user/song(favorite)
    # TODO:       song_partial: should be highlighted. play should turn to pause
    # TODO: update currentTrack

    "click button#pause" : "pauseSong"
    # TODO: pause the current song, keep it playable.

    "click button#next" : "nextSong"
    # TODO: trigger 'stopCurrentSong'
    # TODO: trigger 'getNextSong'
    # TODO: trigger 'playSong'
    # TODO:   on SC.song_finish we also need to trigger getTheNextSong

    "click button#previous" : "previousSong"
    # TODO: trigger 'stopCurrentSong'
    # TODO: trigger 'getPreviousSong'
    # TODO: trigger 'playSong'
    # TODO:   on SC.song_finish we also need to trigger getTheNextSong

    # TODO: basic link
    "click a": "goTo"
    # TODO: these all pertain to 'favoriting' functionality that does not exist yet.
    "click button#nolove" : "noloveSong"
    "click button#love" : "loveSong"
    "click button#like" : "likeSong"
    

  goTo: (e) ->
    url = $(e.currentTarget).attr('href')
    MusicNews.Helpers.openWindow(url, 'Soundcloud')

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