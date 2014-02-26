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

    @player_row = $('#player-row')
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
      if @env.prod() then "http://new.seainhd.com" else "localhost:3000"
    env:
      prod: ->
        hostname = window.location.hostname
        if hostname is "0.0.0.0" or 'localhost' then false else true
      dev: ->
        if !prod() then true else false

    runner: ->
      $item = $('li#move-me')
      $target = $('ul.nav#right-nav')
      $target.append($item)
  } 


$(document).ready ->
  MusicNews.initialize()
  MusicNews.Helpers.runner()
