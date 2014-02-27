class MusicNews.Views.Song extends Backbone.View
  className: 'song-show'

  template: JST['songs/show']

  initialize:() ->
    @listenTo @model, 'change', @render
    @model.fetch()

  render: ->
    @$el.html @template(song: @model)
    this
