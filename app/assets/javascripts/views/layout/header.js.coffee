class MusicNews.Views.Header extends Backbone.View
  id: 'header'
  template: JST['shared/header']

  render: ->
    $markup = $(this.template())
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
