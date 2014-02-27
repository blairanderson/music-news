class MusicNews.Views.SubmissionPartial extends Backbone.View
  className: 'submission'
  template: JST['submissions/_submission']
  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @player     = @app.player
    @$el.html( @template(submission: @model) )
    @target = @$el.find('div.sub-content')

  id: ->
    "submission-#{@model.get('id')}"

  render: ->
    @model.songs.each (song) =>
      song.view = new MusicNews.Views.SongPartial
        model: song
        submission: @submission
        app: @app
      song.view.render()
      @target.append(song.view.$el)
    this

  events:
    "click a" : "goToShow"

  goToShow: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    @router.navigate(target, trigger: true)