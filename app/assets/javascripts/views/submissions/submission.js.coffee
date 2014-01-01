class MusicNews.Views.Submission extends Backbone.View
  template: JST['submissions/show']
  className: 'submission-show'
  initialize: ->
    @router = MusicNews.App.routers.submissions

  render: ->
    _this = this
    markup = @template(submission: @model)
    this.$el.html(markup)
    $target = this.$el.find('div.songs-list')
    @model.songs.each (song) ->
      view = new MusicNews.Views.SongPartial(model: song, submission: _this.model).render().$el
      $target.append view
    this

  events:
    'click h3': 'publisher'

  publisher: ->
    url = "#{window.location.origin}/submissions/#{@model.get('id')}/publisher"
    MusicNews.Helpers.openWindow(url, 'publish')