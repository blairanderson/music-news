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
    MusicNews.App.collections.submissions = new MusicNews.Collections.Submissions()
    MusicNews.App.collections.songs = new MusicNews.Collections.Songs()

    this.App.title = $('title')
    $target = $('#window')
    MusicNews.App.views.layout = new MusicNews.Views.Layout().render()
    $target.append(MusicNews.App.views.layout.$el)
    
    $target = $('#window')
    $body = $('<section/>', class: "content")
    $target.append($body)

    MusicNews.App.views.main     = new MusicNews.Views.Main().render()
    MusicNews.App.views.sidebar  = new MusicNews.Views.Sidebar().render()

    $body.append(MusicNews.App.views.sidebar.$el)
    $body.append(MusicNews.App.views.main.$el)
    
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
