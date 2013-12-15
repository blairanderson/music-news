class MusicNews.Views.Sidebar extends Backbone.View
  id: 'sidebar'
  template: JST['shared/sidebar']

  render: ->
    MusicNews.App.views.player = new MusicNews.Views.Player().render()
    $(@el).html( MusicNews.App.views.player.$el )
    $(@el).append(this.template())
    this
