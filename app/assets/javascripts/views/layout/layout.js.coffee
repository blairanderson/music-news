class MusicNews.Views.Layout extends Backbone.View
  id: 'header'
  template: JST['shared/layout']

  render: ->
    $(@el).html(this.template())
    this

  events: 
    "click nav a" : "goTo"

  goTo: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    MusicNews.App.routers.submissions.navigate(target, trigger:true)
