class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @popular = MusicNews.App.collections.popular_songs
    @songs = MusicNews.App.collections.songs
    MusicNews.App.views.submissions =  []

  routes: 
    '': 'index'
    'popular': 'popular'
    ':id': 'show'
    'song/:id': 'songShow'

  songShow:(data)->
    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
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
    debugger
    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
    if @popular.length
      _target.empty()
      @popular.each (song) ->
        view = new MusicNews.Views.SongPartial(model: song).render()
        _target.append view.$el
    else 
      _target.empty()
      _popular = @popular
      @popular.fetch().done () ->
        _popular.each (song) ->
          debugger
          view = new MusicNews.Views.SongPartial(model: song).render()
          _target.append view.$el
    

  index: (data) ->
    possibleShow = window.location.search.split('id=')[1]
    if possibleShow
      this.navigate(possibleShow, trigger: true)
      return
    possibleSong = window.location.search.split('song=')[1]
    if possibleSong
      this.navigate('song/'+possibleSong, trigger: true)
      return

    _view = @view
    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
    @view = new MusicNews.Views.SubmissionsIndex()
    _view = @view
    if @collection.length
      _target.html @view.render().$el
    else 
      @collection.fetch().done () ->
        _target.html _view.render().$el
    
  show: (data) -> 
    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
    $parent.find('div.hero').html("This is the hero content")

    if @collection.length
      submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
      @currentSubmission = new MusicNews.Views.Submission(model: submission).render()
      MusicNews.App.views.currentSubmission = @currentSubmission
      _target.html(@currentSubmission.$el)
    else
      @collection.fetch().done () ->
        submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
        @currentSubmission = new MusicNews.Views.Submission(model: submission).render()
        MusicNews.App.views.currentSubmission = @currentSubmission
        _target.html(@currentSubmission.$el)
