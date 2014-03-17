class MusicNews.Views.Sidebar extends Backbone.View
  id: 'sidebar'
  template: JST['shared/sidebar']

  render: ->
    $(@el).append(this.template())
    this
