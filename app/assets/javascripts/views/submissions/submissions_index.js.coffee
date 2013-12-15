class MusicNews.Views.SubmissionsIndex extends Backbone.View
  template: JST['submissions/index']
  className: 'submission-list'
  initialize: ->
    @router = MusicNews.App.routers.submissions
    @collection = MusicNews.App.collections.submissions

  render: ->
    markup = @template(submissions: @collection)
    this.$el.html(markup)
    this

  events: 
    "click a" : "goToShow"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)
