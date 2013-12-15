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

    $header = $('<section/>', class: "header")
    $target.append($header)
    this.App.views.layout = new MusicNews.Views.Layout().render()
    $header.append(this.App.views.layout.$el)

    $body = $('<section/>', class: "content")
    $target.append($body)
    
    this.App.views.main = new MusicNews.Views.Main().render()
    $body.append(this.App.views.main.$el)

    this.App.views.sidebar = new MusicNews.Views.Sidebar().render()
    $body.append(this.App.views.sidebar.$el)

    Backbone.history.start()

$(document).ready ->
  MusicNews.initialize()
