class MusicNews.Router extends Backbone.Router

  initialize: (options)->
    @app = options.app
    @app.router = @
    @spinner = $('<div class="spinner"/>')

    @target = @app.content_container
    @target.html @spinner

    @header = @app.views.header = new MusicNews.Views.Header(app: @app)
    @app.header_container.replaceWith(@header.$el)
    @playerDeferred = $.Deferred()

    @playerDeferred.done =>
      @player = @app.player = new MusicNews.Player(app: @app)
      @app.player_row.html @player.$el

    @bind 'all', @_trackPageView

  routes:
    ''          :      -> @routePipeline 'submissions'
    'bloodhound':      -> @routePipeline 'bloodhound'
    'greatest'  :      -> @routePipeline 'greatest'
    'favorites' :      -> @routePipeline 'favorites'
    ':id'       : (id) -> @routePipeline 'song', id
    'sub/:id'   : (id) -> @routePipeline 'submission', id

  routePipeline: (path, id) ->
    @beforeFilters(path)
    @initViewAndAppendToTarget(path, id)
    @afterFilters(path)

  beforeFilters: (path) ->
    console.log 'before filters'
    $(document).scrollTop()
    @target.html @spinner

  initViewAndAppendToTarget: (path, id) ->
    id ||= null
    @currentView.remove() if @currentView
    @currentView = @[path](id)
    @target.html(@currentView.$el)
    @app.currentCollection = @currentView.collection
    @playerDeferred.resolve()

  afterFilters: (path) ->
    console.log('after filters')
    @header.activate(path)

  submission: (id) ->
    unless id?
      @navigate('/')
      return
    submission = new MusicNews.Models.Submission(id: id, fetch: true)
    @target.html @spinner
    new MusicNews.Views.Submission(model: submission)

  bloodhound: ->
    new MusicNews.Views.Bloodhound
      app: @app

  song: (id) ->
    song = new MusicNews.Models.Song(id: id, fetch: true)
    @target.html @spinner

    new MusicNews.Views.Song
      model: song
      collection: new MusicNews.Collections.Songs([song], fetch: false)

  submissions: ->
    songs = @app.collections.latest_songs = new MusicNews.Collections.Songs()
    submissions = new MusicNews.Collections.Submissions()
    new MusicNews.Views.SubmissionsIndex(submissions: submissions, collection: songs, app: @app)

  greatest: ->
    songs = @app.collections.popular_songs = new MusicNews.Collections.Songs(sort: 'popular', fetch: true)
    new MusicNews.Views.Songs(collection: songs, app: @app)

  favorites: ->
    songs = @app.collections.favorite_songs = new MusicNews.Collections.Songs(sort: 'popular', fetch: true)
    new MusicNews.Views.Songs(collection: songs, app: @app)

  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])
