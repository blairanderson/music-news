class MusicNews.Views.SubmissionPartial extends Backbone.View
  className: 'submission'
  template: JST['submissions/_submission']
  initialize: (options) ->
    @submission = options.model

  render: ->
    markup = @template(submission: @submission)
    this.$el.html(markup)
    this.$el.attr('id', "submission-#{@submission.get('id')}" )
    this

  events:
    "click a" : "goToShow"
    "click button.play" : "playSong"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)

  playSong: (e) ->
    e.preventDefault()


