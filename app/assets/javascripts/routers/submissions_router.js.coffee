class MusicNews.Routers.Submissions extends Backbone.Router
  initialize: ->
    @collection = new MusicNews.Collections.Submissions()
    @collection.fetch()
    MusicNews.App.collections.submissions = @collection
  routes: 
    'new': 'nothing'
    '': 'index'
    ':id': 'show'

  nothing: ->
    console.log('nothing')

  index: ->
    collection = new MusicNews.Collections.Submissions()
    collection.fetch()
    view = new MusicNews.Views.SubmissionsIndex().render()
    

  show: -> 
    debugger
    alert 'submissions show'