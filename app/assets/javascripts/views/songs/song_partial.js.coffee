class MusicNews.Views.SongPartial extends Backbone.View
  className: 'song'
  template: JST['submissions/_song']
  initialize: (options) ->
    @song = options.model
    options.model.view = this
    @button = this.$el.find("button.play")
    @player = MusicNews.App.views.player
    @router = MusicNews.App.routers.submissions

  render: ->
    markup = @template(song: @song)
    this.$el.html(markup)

    this.$el.attr('id', "song-#{@song.get('id')}" )
    this

  events:
    "click a" : "goToShow"
    "click button.play, button.pause" : "buttonHandler"
    "click button.facebook" : "facebook"
    "click button.twitter" : "twitter"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)
  buttonHandler: (e) ->
    e.preventDefault()
    @button = $(e.currentTarget)
    $action = @button.attr('class')
    this[$action](@button)
    @playPauseAddClass()

  play: ->
    @player.pauseSong()

    @player.currentSound = undefined
    @player.currentTrack = @song
    if @song
      markup = @player.playlistSongTemplate(song: @song )
      @player.$el.find('#playlist').html markup
    @player.playSong()
  pause: ->
    @player.pauseSong()
  facebook: ->

  twitter: ->


  playPauseAddClass: ->
    this.$el.addClass("active")
    @button.toggleClass('play pause')