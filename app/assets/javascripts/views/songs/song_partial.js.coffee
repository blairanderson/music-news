class MusicNews.Views.SongPartial extends Backbone.View
  className: 'song'
  template: JST['submissions/_song']

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @submission = options.submission
    @player     = @app.player

  id: ->
    "song-#{@model.get('id')}"

  render: ->
    @$el.html(@template(song: @model))
    this

  events:
    'click a'       : 'goToShow'
    'click button'  : 'buttonHandler'

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)

  deactivate: ->
    @$el.removeClass('active')
    @$el.find('.pause').attr('class', 'play')

  activate: ->
    @$el.addClass('active')
    @$el.find('.play').attr('class', 'pause')

  buttonHandler: (e) ->
    e.preventDefault()
    $action = $(e.currentTarget).attr('class')
    this[$action]()

  play: ->
    @player.pauseSong()

    @player.currentSound = undefined
    @player.currentTrack = @song
    if @song
      markup = @player.playlistSongTemplate(song: @song )
      @player.$el.find('#playlist').html markup
    @player.playSong()
    @playPauseAddClass("play")
    
  pause: ->
    @player.pauseSong()
    @playPauseAddClass("pause")

  facebook: ->
    MusicNews.Helpers.openWindow(@submission.get('share'), "FACEBOOP DAT")

  twitter: ->
    MusicNews.Helpers.openWindow(@submission.get('tweet'), "TWOOT dat")
  
  button: ->
    this.$el.find('button.play, button.pause')

  playPauseAddClass: (state) ->
    if state = 'play'
      this.$el.addClass("active")
      @button().addClass('pause').removeClass('play')
      return
    if state = 'pause'
      this.$el.removeClass("active")
      @button().removeClass('pause').addClass('play')
      return
