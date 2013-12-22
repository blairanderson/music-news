class MusicNews.Views.Layout extends Backbone.View
  id: 'header'
  template: JST['shared/layout']

  render: ->
    $markup = $(this.template())

    MusicNews.App.views.player = new MusicNews.Views.Player().render()
    $markup.find('div#player-container').html( MusicNews.App.views.player.$el )
    $(@el).html($markup)
    this

  events: 
    "click a[href='/']" : "goTo"

  goTo: (e) ->
    e.preventDefault()
    target = $(e.currentTarget).attr('href')
    MusicNews.App.routers.submissions.navigate(target, trigger:true)
