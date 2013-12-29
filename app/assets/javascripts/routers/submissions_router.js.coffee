class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @songs = MusicNews.App.collections.songs
    MusicNews.App.views.submissions =  []


  routes: 
    '': 'index'
    ':id': 'show'
    '/?id=:id': 'show'

  index: (data) ->
    possibleShow = window.location.search.split('=')[1]
    if possibleShow
      this.navigate(possibleShow, trigger: true)
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
