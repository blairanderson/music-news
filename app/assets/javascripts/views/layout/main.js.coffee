class MusicNews.Views.Main extends Backbone.View
  id: 'main'
  template: JST['shared/main']
  initialize: ->
    new MusicNews.Routers.Submissions
    
  render: ->
    $(@el).html(this.template())
    this
