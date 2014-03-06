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
        onfinish:     @_onfinish
        onload:       @_onload
        onpause:      @_onpause
        onplay:       @_onplay
        whileplaying: @_whileplaying
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

  _whileplaying: ->
    percent = (this.position / this.durationEstimate) * 100
    MusicNews.player.currentTrack.set('percent', percent)

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
    @stopListening(@currentTrack)
    @currentTrack = @app.currentCollection.at(@currentTrackIndex)
    @listenForChangeOn(@currentTrack)
    # @listenTo(@currentTrack, 'change', @render);

  bindings:
    'i.clock' : 'percent'
    '.progress-bar':
      name: 'style',
      observe: 'percent',
      onGet: 'formatPercent'

  formatPercent: (val) ->
    "width: #{val}%"

  updater: (args, model)->
    selector = args[0]
    options  = args[1]
    if _.isString(options)
      @$(selector).text(model.get(options))
    else
      modelAttrValue = model.get(options.observe)
      formattedValue = this[options.onGet](modelAttrValue)
      @$(selector).attr(options.name, formattedValue)

  listenForChangeOn: (model, optionalBindings) ->
    bindings = optionalBindings || @bindings
    for selector_options in _.pairs(bindings)
      selector = selector_options[0]
      options = selector_options[1]
      if _.isString(options)
        @listenTo(model, "change:#{options}", =>
          @updater(selector_options, model))
      else
        @listenTo(model, "change:#{options.observe}", =>
          @updater(selector_options, model))

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

  session: ->
    MusicNews.session

  _canFavorite: ->
    @session() && !@session().isNew()

  userFavorite: (e) ->
    e.preventDefault()
    if @_canFavorite()
      @favorites ||= new MusicNews.Collections.Favorites()
      @api_secret ||= {}
      _.extend(@api_secret, api_token: @session().get('api_token') ) if @session().get('api_token')
      _.extend(@api_secret, api_secret: @session().get('api_secret') ) if @session().get('api_secret')
      $button = $(e.currentTarget)
      @[$button.attr('id')]( $button )
    else
      request = new MusicNews.Models.FeatureRequest("loginRequired")
      @modal = new Backbone.BootstrapModal(request.modalOptions()).open()

  nolove: ($button) ->
    favorite = new MusicNews.Models.Favorite
      tag: 'love'
      song_id: @currentTrack.get('id')
    @favorites.create favorite,
      wait: true
      data: $.param _.extend @api_secret, {user_song_tag: favorite.attributes}
      success: ->
        $button.attr('id', 'love')

    # change from love to like
  love:   ($button) ->
    $button.attr('id', 'nolove')
    # remove the favorite!
    debugger

  # like:   ($button) ->
  #   $button.attr('id', 'nolove')
  #   # delete the favorite
  #   debugger
