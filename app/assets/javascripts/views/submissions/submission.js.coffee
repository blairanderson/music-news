class MusicNews.Views.Submission extends Backbone.View

  template: JST['submissions/show']

  className: 'submission-show'

  initialize: ->
    @model.deferred.done =>
      @render()

  render: ->
    markup = @template(submission: @model)
    @$el.html(markup)
    $target = this.$el.find('div.songs-list')
    @model.songs.each (song) ->
      view = new MusicNews.Views.SongPartial
        model: song
        submission: @model
        app: @app
      view.render()
      $target.append view.$el
    this

  events:
    'click h3': 'publisher'

  publisher: ->
    url = "#{window.location.origin}/submissions/#{@model.get('id')}/publisher"
    MusicNews.Helpers.openWindow(url, 'publish')