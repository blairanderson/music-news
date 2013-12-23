class MusicNews.Views.SubmissionsIndex extends Backbone.View
  className: 'submission-list'

  initialize: ->
    @router = MusicNews.App.routers.submissions
    @collection = MusicNews.App.collections.submissions

  render: ->
    _this = this
    @collection.each (submission) ->
      view = new MusicNews.Views.SubmissionPartial(model: submission).render().$el
      _this.$el.append view
    this