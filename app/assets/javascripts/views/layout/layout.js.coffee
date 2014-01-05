class MusicNews.Views.Layout extends Backbone.View
  id: 'header'
  template: JST['shared/layout']

  render: ->
    $markup = $(this.template())
    $playerContainer = $markup.find('div#player-container')

    MusicNews.App.views.player = new MusicNews.Views.Player().render()
    $playerContainer.html( MusicNews.App.views.player.$el )
    $playerContainer.affix()
    $(@el).html($markup)
    this

  events: 
    "click a" : "goTo"

  goTo: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    if target == '#tour'
      @startTour(e)
      return
    MusicNews.App.routers.submissions.navigate(target, trigger:true)

  startTour: (e)->
    console.log 'start tour'
    return
