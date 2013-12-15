class MusicNews.Views.Submission extends Backbone.View
  template: JST['submissions/show']
  className: 'submission'
  initialize: ->
    @router = MusicNews.App.routers.submissions

  render: ->
    markup = @template(submission: @model)
    this.$el.html(markup)
    this