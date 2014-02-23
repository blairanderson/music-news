class MusicNews.Views.SubmissionsIndex extends Backbone.View
  className: 'submission-list'
    
  initialize:(options) ->
    @collection = options.collection
    @app        = options.app
    @target     = @$el
    @collection.deferred.done =>
      @render()

  render: ->
    @collection.each (item) =>
      item.view = new MusicNews.Views.SubmissionPartial(model: item, app: @app)
      item.view.render()
      @target.append item.view.$el
    this
