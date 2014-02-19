class MusicNews.Routers.Router extends Backbone.Router
  routes:
    '': 'submissions'

  initialize: ->
    @header = new MusicNews.Views.Header(router: this)
    $('#window').html(@header.render.el)
    @target = $('<div id="target"/>')
    $('#window').append(@target)

    @bind 'all', @_trackPageView

  beforeFilters: (routeHandler) ->
    @handleRedirects()

  handleRedirects: ->
    possibleShow = window.location.search.split('id=')[1]
    if possibleShow
      this.navigate(possibleShow, trigger: true)
      return
    # redirect to song-show
    possibleSong = window.location.search.split('song=')[1]
    if possibleSong
      this.navigate('song/'+ possibleSong, trigger: true)
      return
    
  submissions: (data) ->
    @submissions = new MusicNews.Collections.Submissions()
    view = new MusicNews.Views.SubmissionsIndex(collection: @submissions).render()
    @target.html(view.$el)
    

  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])