class MusicNews.Views.SubmissionPartial extends Backbone.View
  className: 'submission'
  template: JST['submissions/_submission']
  initialize: (options) ->
    @submission = options.model
    options.model.view = this
    @router = MusicNews.App.routers.submissions
    @player = MusicNews.App.views.player

  id: =>
    "submission-#{@model.get('id')}"
    
  render: ->
    markup = @template(submission: @submission)
    this.$el.html(markup)
    _this = this
    @submission.songs.each (song) =>
      view = new MusicNews.Views.SongPartial(model: song, submission: @submission).render().$el
      @$el.find('div.sub-content').append view
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


