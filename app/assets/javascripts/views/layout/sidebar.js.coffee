class MusicNews.Views.Sidebar extends Backbone.View
  id: 'sidebar'
  template: JST['shared/sidebar']

  render: ->
    $(@el).html(this.template())
    this
