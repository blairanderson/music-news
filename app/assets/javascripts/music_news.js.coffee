window.MusicNews =
  Models: {}
  models: {}
  Collections: {}
  collections: {}
  Views: {}
  views: {}
  Routers: {}
  initialize: ->
    @title = $('title')

    $spinner = $('<div class="spinner"/>')

    @header_container = $('#header')
    @header_container.html($spinner)

    @player_container = $('#player')
    @main_container = $('#container')
    @content_container = $('#content')
    @sidebar_container = $('#sidebar')
    @footer_container = $('#footer')

    @sidebar  = new MusicNews.Views.Sidebar().render()
    @sidebar_container.replaceWith(@sidebar.$el)

    @player = {}
    @session = new MusicNews.Session();
    # loading screen
    @session.deferred.done =>
      @router = new MusicNews.Router(app: this)
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
