class MusicNews.Views.SubmissionsIndex extends Backbone.View
  className: 'submission-list'

  initialize:(options) ->
    @collection   = options.collection
    @submissions  = options.submissions
    @app          = options.app
    @target       = @$el
    @submissions.deferred.done =>
      @render()

  render: ->
    @submissions.each (item) =>
      item.view = new MusicNews.Views.SubmissionPartial(model: item, app: @app)
      item.view.render()
      @target.append item.view.$el
    this
