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
    $target = $('#window')

    this.App.views.layout = new MusicNews.Views.Layout().render()
    $target.append(this.App.views.layout.$el)

    $body = $('<section/>', class: "content")
    $target.append($body)

    this.App.views.main     = new MusicNews.Views.Main().render()
    this.App.views.sidebar  = new MusicNews.Views.Sidebar().render()

    $body.append(this.App.views.main.$el)
    $body.append(this.App.views.sidebar.$el)

    Backbone.history.start({pushState: true})

$(document).ready ->
  MusicNews.initialize()
