class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = MusicNews.App.collections.submissions
    @songs = MusicNews.App.collections.songs

  routes: 
    '': 'index'
    ':id': 'show'
    '/?id=:id': 'show'

  index: (data) ->
    possibleShow = window.location.search.split('=')[1]
    if possibleShow
      this.navigate(possibleShow, trigger: true)
      return

    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
    if @collection.length
      view = new MusicNews.Views.SubmissionsIndex().render()
      _target.html(view.$el)
    else 
      @collection.fetch().done () ->
        view = new MusicNews.Views.SubmissionsIndex().render()
        _target.html(view.$el)
    
  show: (data) -> 
    $parent = MusicNews.App.views.main.$el
    $target = $parent.find('div.body')
    _target = $target
    $parent.find('div.hero').html("This is the hero content")

    if @collection.length
      submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
      submission.fetch()
      view = new MusicNews.Views.Submission(model: submission).render()
      _target.html(view.$el)
    else
      @collection.fetch().done () ->
        submission = MusicNews.App.collections.submissions.findWhere({id: parseInt(data)})
        submission.fetch()
        view = new MusicNews.Views.Submission(model: submission).render()
        _target.html(view.$el)
