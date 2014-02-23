class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @songs = MusicNews.App.collections.songs
    MusicNews.App.views.submissions =  []
    @bind 'all', @_trackPageView

  routes: 
    'popular': 'popular'
    ':id': 'show'
    'song/:id': 'songShow'

          
  show: (data) -> 
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

  songShow:(data)->
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
        
  _trackPageView: ->
    url = Backbone.history.getFragment
    _gaq.push(['_trackPageView', url])