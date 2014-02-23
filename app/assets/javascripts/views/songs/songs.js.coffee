class MusicNews.Views.Songs extends Backbone.View
  className: 'song-list'

  initialize:(options) ->
    @collection = options.collection
    @app        = options.app
    @target     = @$el
    @collection.deferred.done =>
      @render()

  render: ->
    @collection.each (item) =>
      item.view = new MusicNews.Views.SongPartial(model: item, app: @app)
      item.view.render()
      @target.append item.view.$el
    this
