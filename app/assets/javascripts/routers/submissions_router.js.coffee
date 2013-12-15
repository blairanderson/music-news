class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = new MusicNews.Collections.Submissions()
    MusicNews.App.collections.submissions = @collection
  routes: 
    'new': 'nothing'
    '': 'index'
    ':id': 'show'

  nothing: ->
    console.log('nothing')

  index: ->
    @collection.fetch().done (data, stuff) ->
      view = new MusicNews.Views.SubmissionsIndex().render()
      MusicNews.App.views.main.$el.html(view.$el)
    

  show: -> 
    debugger
    alert 'submissions show'