class MusicNews.Views.SongPartial extends Backbone.View
  className: 'song'
  template: JST['submissions/_song']
  initialize: (options) ->
    @song = options.model
    @player = MusicNews.App.views.player

  render: ->
    markup = @template(song: @song)
    this.$el.html(markup)
    this.$el.attr('id', "song-#{@song.get('id')}" )
    this

  events:
    "click a" : "goToShow"
    "click button.play" : "playSong"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)

  playSong: (e) ->
    e.preventDefault()

    @player.pauseSong()

    @player.currentSound = undefined
    @player.currentTrack = @song
    if @song
      markup = @player.playlistSongTemplate(song: @song )
      @player.$el.find('#playlist').html markup
    @player.playSong()


