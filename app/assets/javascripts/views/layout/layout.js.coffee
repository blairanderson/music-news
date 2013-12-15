class MusicNews.Views.Layout extends Backbone.View
  id: 'header'
  template: JST['shared/layout']

  render: ->
    $(@el).html(this.template())
    this
