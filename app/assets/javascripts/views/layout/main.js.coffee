class MusicNews.Views.Main extends Backbone.View
  id: 'main'
  template: JST['shared/main']

  render: ->
    $(@el).html(this.template())
    this
