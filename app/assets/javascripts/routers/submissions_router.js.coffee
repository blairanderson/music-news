class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @songs = MusicNews.App.collections.songs
    MusicNews.App.views.submissions =  []
    @bind 'all', @_trackPageView

  routes: 
    '': 'index'
    'popular': 'popular'
    ':id': 'show'
    'song/:id': 'songShow'

  songShow:(data)->
    @target = MusicNews.App.views.main.$el.find('div.body')
    _target = @target
    if @songs.length
      song = @songs.findWhere({id: parseInt(data)})
      @currentSong = new MusicNews.Views.SongPartial(model: song).render()
      _target.html(@currentSong.$el)
    else
      @collection.fetch().done () ->
        song = MusicNews.App.collections.songs.findWhere({id: parseInt(data)})
        @currentSong = new MusicNews.Views.SongPartial(model: song).render()
        _target.html(@currentSong.$el)


  popular: (data) ->
    @target = MusicNews.App.views.main.$el.find('div.body')
    _target = @target
    if @songs.length
      _target.empty()
      @songs.each (song) ->
        view = new MusicNews.Views.SongPartial(model: song).render()
        _target.append view.$el
    else 
      _target.empty()
      _songs = @songs
      @songs.fetch().done () ->
        _songs.each (song) ->
          view = new MusicNews.Views.SongPartial(model: song).render()
          _target.append view.$el

  index: (data) ->
    @target = MusicNews.App.views.main.$el.find('div.body')

    # redirect to submission-show
    possibleShow = window.location.search.split('id=')[1]
    if possibleShow
      this.navigate(possibleShow, trigger: true)
      return
    # redirect to song-show
    possibleSong = window.location.search.split('song=')[1]
    if possibleSong
      this.navigate('song/'+ possibleSong, trigger: true)
      return

    _target = @target
    _view = new MusicNews.Views.SubmissionsIndex()
    if @collection.length
      _target.html _view.render().$el
    else 
      @collection.fetch().done () ->
        _target.html _view.render().$el
    
  show: (data) -> 
    @target = MusicNews.App.views.main.$el.find('div.body')
    _target = @target
    if @collection.length
      submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
      view = new MusicNews.Views.Submission(model: submission).render()
      _target.html view.$el
    else
      @collection.fetch().done () ->
        submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
        view = new MusicNews.Views.Submission(model: submission).render()
        _target.html view.$el

  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])