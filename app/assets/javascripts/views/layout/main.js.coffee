class MusicNews.Views.Main extends Backbone.View
  id: 'main'
  template: JST['shared/main']
  initialize: ->
    @router = new MusicNews.Routers.Submissions
    MusicNews.App.routers.submissions = @router

  render: ->
    $(@el).html(this.template())
    @hero = $(@el).find('div.hero')
    @body = $(@el).find('div.body')
    @router.target = @body
    this