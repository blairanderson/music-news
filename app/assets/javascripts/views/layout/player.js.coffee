class MusicNews.Views.Player extends Backbone.View
  id: 'music-player'
  className: 'container'
  template: JST['shared/player']
  initialize: ->
    @api = SC
    @api.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");

  render: ->
    $(@el).html(this.template())
    this
