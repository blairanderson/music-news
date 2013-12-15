class MusicNews.Routers.Router extends Backbone.Router
  routes:
    '': 'layout'

  layout: -> 
    alert('inside the router')
    this.App.layout = new MusicNews.Views.layout()
