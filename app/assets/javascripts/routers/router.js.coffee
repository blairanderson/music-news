class MusicNews.Router extends Backbone.Router

  initialize: (options)->
    @app = options.app
    @target = @app.content_container
    @app.router = this

    @header = @app.views.header = new MusicNews.Views.Header(app: @app)
    @app.header_container.replaceWith(@header.$el)
    
    @bind 'all', @_trackPageView

  routes:
    ''        : -> @routePipeline 'submissions'
    'greatest': -> @routePipeline 'greatest'

  routePipeline: (path) ->
    @beforeFilters(path)
    @appendToTarget(path)
    @afterFilters(path)
    
  beforeFilters: (path) ->
    console.log 'before filters'
    @target.html $('<div class="spinner"/>')

  appendToTarget: (path) ->
    view = @[path]()
    @target.html(view.$el)

  afterFilters: (path) ->
    console.log('after filters')
    @header.activate(path)

  submissions: ->
    @submissions = @app.collections.submissions = new MusicNews.Collections.Submissions()
    view = @app.views.submissions_index = new MusicNews.Views.SubmissionsIndex(collection: @submissions,app: @app)

  greatest: ->
    @songs = @app.collections.popular_songs = new MusicNews.Collections.Songs(sort: 'popular', fetch: true)
    view = new MusicNews.Views.SongIndex(collection: @songs, app: @app)

  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])  