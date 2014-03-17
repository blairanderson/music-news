class MusicNews.Views.Bloodhound extends Backbone.View

  id: 'bloodhound'

  className: 'full-width'

  template: JST['shared/bloodhound']

  events:
    'keyup :input'  : 'verifyInput'
    'keydown :input': 'verifyInput'

  initialize: (options) ->
    @app      = options.app
    @router   = @app.router
    @session  = @app.session
    @render()

  render: ->
    $markup = @template()
    @$el.html($markup)
    this

  verifyInput: (e) ->
    $target = $(e.currentTarget).val()
    if @urlIsValid($target)
      if @urlIsSoundcloud($target)
        @appendResult("Does this look right?")
        @$('#embedResult').html @soundcloudEmbed($target)
      else
        @appendResult('scraping page brb...')
        $.ajax
          type: 'POST'
          url: 'bloodhound'
          data: {url: $target, type: 'url'}
          dataType: "JSON"
          success: (data) =>
            links = data.links
            iframes = data.iframes
            for link in links
              @$('#embedResult').append @soundcloudEmbed(link)
            for iframe in iframes
              soundcloudIframe = $('<iframe width="100%" height="450" scrolling="no" frameborder="no">').attr('src', iframe)
              @$('#embedResult').append soundcloudIframe

          error: (data) =>
            @appendResult('could not find shit... try again...')
    else
      @appendResult('not a valid url')

  soundcloudEmbed: (url) ->
    SC.oEmbed url
    , color: "ff0066"
    , (oembed) =>
      oembed?.html


  urlIsValid: (url)->
    regex = /^(ht|f)tps?:\/\/[a-z0-9-\.]+\.[a-z]{2,4}\/?([^\s<>\#%"\,\{\}\\|\\\^\[\]`]+)?$/
    url.match(regex)

  urlIsSoundcloud: (url) ->
    regexp = /^https?:\/\/(soundcloud.com|snd.sc)\/(.*)$/
    url.match(regexp)

  appendResult: (result) ->
    @$('.results').text(result)
