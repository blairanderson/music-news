class MusicNews.Router extends Backbone.Router

  initialize: (options)->
    @app = options.app
    @target = @app.content_container
    @app.router = this

    @spinner = $('<div class="spinner"/>')

    @header = @app.views.header = new MusicNews.Views.Header(app: @app)
    @app.header_container.replaceWith(@header.$el)

    @app.content_container.html @spinner

    @player = @app.player = new MusicNews.Player(app: @app)
    @app.player_row.html @player.$el

    @bind 'all', @_trackPageView

  routes:
    ''          : -> @routePipeline 'submissions'
    'greatest'  : -> @routePipeline 'greatest'
    'favorites' : -> @routePipeline 'favorites'

  routePipeline: (path) ->
    @beforeFilters(path)
    @appendToTarget(path)
    @afterFilters(path)
    
  beforeFilters: (path) ->
    console.log 'before filters'
    $(document).scrollTop()
    @target.html @spinner

  appendToTarget: (path) ->
    view = @[path]()
    @target.html(view.$el)
    @app.currentCollection = view.collection

  afterFilters: (path) ->
    console.log('after filters')
    @header.activate(path)

  submissions: ->
    songs = @app.collections.latest_songs = new MusicNews.Collections.Songs()
    submissions = new MusicNews.Collections.Submissions()
    view = new MusicNews.Views.SubmissionsIndex(submissions: submissions, collection: songs, app: @app)

  greatest: ->
    songs = @app.collections.popular_songs = new MusicNews.Collections.Songs(sort: 'popular', fetch: true)
    view = new MusicNews.Views.Songs(collection: songs, app: @app)

  favorites: ->
    # if session.isNew()
    # redirect to root with alert "must be logged in"
    songs = @app.collections.favorite_songs = new MusicNews.Collections.Songs(sort: 'popular', fetch: true)
    view = new MusicNews.Views.Songs(collection: songs, app: @app)

  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])  