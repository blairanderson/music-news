class MusicNews.Views.Main extends Backbone.View
  id: 'main'
  template: JST['shared/main']
  initialize: ->
    MusicNews.App.routers.submissions = new MusicNews.Routers.Submissions

  render: ->
    $(@el).html(this.template())
    @hero = $(@el).find('div.hero')
    @body = $(@el).find('div.body')
    this