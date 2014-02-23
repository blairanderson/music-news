class MusicNews.Views.Header extends Backbone.View
  initialize: (options) ->
    @app      = options.app
    @router   = @app.router
    @session  = @app.session
    @session.on "change", @render
    @render()

  id: 'header'

  className: 'full-width'

  template: JST['shared/header']

  activate: (action) ->
    @$el.find('li').removeClass('active')
    @$el.find(".#{action}").parent().addClass('active')

  render: ->
    $markup = @template(session: @session)
    @$el.html($markup)
    this

  events: 
    "click a" : "goTo"

  goTo: (e) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    $route = $target.attr('href')
    if $target.data('external')
      url = "#{window.location.origin}#{$route}"
      window.location.href = url
    else
      @router.navigate($route, trigger: true)
