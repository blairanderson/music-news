class MusicNews.Views.Song extends Backbone.View
  className: 'song-show'

  template: JST['songs/show']

  initialize:(options) ->
    @model.on 'reset', @render

  render: ->
    @$el.html @template(song: @model)
    this
