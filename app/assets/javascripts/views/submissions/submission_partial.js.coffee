class MusicNews.Views.SubmissionPartial extends Backbone.View
  className: 'submission'
  template: JST['submissions/_submission']
  initialize: (options) ->
    @submission = options.model
    options.model.view = this
    @player = MusicNews.App.views.player

  render: ->
    markup = @template(submission: @submission)
    this.$el.html(markup)
    this.$el.attr('id', "submission-#{@submission.get('id')}" )
    this.setSongViews()

    this

  setSongViews: ->
    _this = this

    @submission.songs.each (song) ->
      view = new MusicNews.Views.SongPartial(model: song).render().$el
      _this.$el.find('div.sub-content').append view

  events:
    "click a" : "goToShow"
    "click button.play" : "playSong"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)

  playSong: (e) ->
    e.preventDefault()


