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
    this.App.title = $('title')
    $target = $('#window')
    @header = new MusicNews.Views.Header().render()
    $target.append(@header.$el)
    $body = $('<section/>', class: "content")
    $target.append($body)

    @main     = new MusicNews.Views.Main().render()
    $body.append(@main.$el)

    @sidebar  = new MusicNews.Views.Sidebar().render()
    $body.append(@sidebar.$el)

    @router = new MusicNews.Routers.Router

    Backbone.history.start({pushState: true})

  Helpers: {
    openWindow: (url, name) ->
      window.open(url, name, "height=800,width=900")

    urlBase: ->
      if this.env.prod()
        "/"
      else
        "http://new.seainhd.com/"
    env: {
      prod: ->
        if window.location.hostname == "0.0.0.0"
          false
        else
          true
      dev: ->
        if window.location.hostname == "0.0.0.0"
          true
        else
          false
    }
    runner: ->
      $item = $('li#move-me')
      $target = $('ul.nav#right-nav')
      $target.append($item)
  } 


$(document).ready ->
  MusicNews.initialize()
  MusicNews.Helpers.runner()
