class MusicNews.Views.SubmissionsIndex extends Backbone.View

  template: JST['submissions/index']
  initialize: ->
    @collection = MusicNews.App.collections.submissions

  render: ->
    MusicNews.App.views.main.$el.html(this.template(@collection))
    this
