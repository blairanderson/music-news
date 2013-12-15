class MusicNews.Views.SubmissionsIndex extends Backbone.View

  template: JST['submissions/index']
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @collection.on('reset', @render, this)

  render: ->
    markup = @template(submissions: @collection)
    this.$el.html(markup)
    this

  check: ->
    alert "collection reset"