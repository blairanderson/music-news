class MusicNews.Views.Layout extends Backbone.View
  template: JST['shared/layout']

  render: ->
    $(@el).html(this.template())
    this
