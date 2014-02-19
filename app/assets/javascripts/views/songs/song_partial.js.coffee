class MusicNews.Views.SongPartial extends Backbone.View
  className: 'song'
  template: JST['submissions/_song']
  initialize: (options) ->
    @song = options.model
    @submission = options.submission
    options.model.view = this
    @player = MusicNews.App.views.player
    @router = MusicNews.App.routers.submissions
    MusicNews.App.title.text( this.model.get('title') )

  id: ->
    "song-#{@model.get('id')}"

  render: ->
    markup = @template(song: @song)
    this.$el.html(markup)
    # $('[data-spy="scroll"]').each( -> $(this).scrollspy('refresh') )

    # this should be the collections job!!!
    # if @model == @player.currentTrack
    #   @playPauseAddClass('play')
    this

  events:
    "click a"                         : "goToShow"
    "click button.play, button.pause" : "buttonHandler"
    "click button.facebook"           : "facebook"
    "click button.twitter"            : "twitter"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)
  buttonHandler: (e) ->
    e.preventDefault()
    $action = $(e.currentTarget).attr('class')
    this[$action]()
    @playPauseAddClass($action)

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
