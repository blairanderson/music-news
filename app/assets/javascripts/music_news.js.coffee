window.MusicNews =
  App: {
    models: {}
    collections: {}
    views: {}
    routers: {}
  }

  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    this.App.views = new MusicNews.Views.Layout().render()
    $('#window').append(this.App.views.$el)
    Backbone.history.start()

$(document).ready ->
  MusicNews.initialize()
