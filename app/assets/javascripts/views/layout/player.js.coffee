class MusicNews.Player extends Backbone.View
  id: 'music-player'

  className: 'container'

  template: JST['shared/player']

  playlistSongTemplate: JST['shared/track']

  currentTrackIndex: 0

  initialize: (options) ->
    @app = options.app
    $(document).on 'keydown', @keyBoardShortCuts

    SC.initialize
      client_id: "c024bdd48e9ecf014c71af406201f3a2"
      redirect_uri: "#{MusicNews.Helpers.urlBase()}/auth/soundcloud/callback"

    SC.whenStreamingReady =>
      @app.currentCollection.deferred.done =>
        @setCurrentTrack()
        @render()

  render: ->
    $markup = @template
      currentTrack: @currentTrack
      currentSound: @currentSound
    @$el.html $markup

    @playPauseButton = @$el.find('[data-action="play-pause"]')
    this

  events:
    'click a#play'          : 'playCurrentSound'
    'click a#pause'         : 'pauseSong'
    'click a#next'          : 'nextSong'
    'click a#previous'      : 'previousSong'
    'click a#love'          : 'userFavorite'
    'click a#like'          : 'userFavorite'
    'click a#nolove'        : 'userFavorite'

  playCurrentSound: (e) ->
    e.preventDefault() if e
    if @currentSound
      @currentSound.play
        onload:       @_onload
        onplay:       @_onplay
        onpause:      @_onpause
        onfinish:     @_onfinish
        # ontimeout:    @_ontimeout
        # whileplaying: @_whileplaying
    else
      @setCurrentSound()
      @playCurrentSound()


  _onload: (loaded) =>
    if !loaded
      @currentCollection.remove @currentTrack
      @currentTrack.save invalid: true
      @nextSong()

  _onfinish: =>
    @currentTrack.view.deactivate()
    @playPauseButton.attr('id', 'play')
    @nextSong()

  # _whileplaying: =>
  #   debugger
  #   console.log("sound #{this.id} playing, #{this.position} of #{this.durationEstimate}")

  _onpause: =>
    @playPauseButton.attr('id', 'play')
    @currentTrack.view.deactivate()

  _onplay: =>
    $('.song').removeClass "active"
    @playPauseButton.attr('id', 'pause')
    @currentTrack.view.activate()

  setCurrentSound: () ->
    $stream_url = @streamUrl()
    if $stream_url is null or undefined
      @advanceTrackIndex()
      @setCurrentSound()

    SC.stream $stream_url, (sound) =>
      @currentSound = sound

  streamUrl: ->
    if @currentTrack && @currentTrack.get('stream_url')
      $stream_url = @currentTrack.get('stream_url')
    else
      $stream_url = null
    $stream_url

  setCurrentTrack: ->
    @currentSound = null
    @currentTrack = @app.currentCollection.at(@currentTrackIndex)

  advanceTrackIndex: ->
    @currentTrackIndex = @currentTrackIndex + 1
    if @currentTrackIndex == @_currentCollectionLength()
      @currentTrackIndex = 0

  revertTrackIndex: ->
    @currentTrackIndex = @currentTrackIndex - 1
    if @currentTrackIndex == -1
      @currentTrackIndex = @_currentCollectionLength() - 1

  _currentCollectionLength: ->
    @app.currentCollection.length

  nextSong: (e) ->
    e.preventDefault() if e
    @pauseSong()
    @advanceTrackIndex()
    @setCurrentTrack()
    @render()
    @playCurrentSound()

  previousSong: (e) ->
    e.preventDefault() if e
    @pauseSong()
    @revertTrackIndex()
    @setCurrentTrack()
    @render()
    @playCurrentSound()

  pauseSong: (e) ->
    e.preventDefault() if e
    @currentSound.pause() if @currentSound

  keyBoardShortCuts: (e) =>
    if e.keyCode == 32
      e.preventDefault()
      @playPauseButton.click()
    if e.keyCode == 39
      e.preventDefault()
      @nextSong()
    if e.keyCode == 37
      e.preventDefault()
      @previousSong()

  userFavorite: (e) ->
    e.preventDefault()
    $button = $(e.currentTarget)
    @[$button.attr('id')]( $button )

  nolove: ($button) ->
    # do stuff
    $button.attr('id', 'love')

  love:   ($button) ->
    # do stuff
    $button.attr('id', 'like')

  like:   ($button) ->
    # do stuff
    $button.attr('id', 'nolove')
