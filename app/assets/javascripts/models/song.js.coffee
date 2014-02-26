class MusicNews.Models.Song extends Backbone.Model

  url: ->
    '/songs#{@id}'

  initialize: (options)->
    
    if options.fetch
      @deferred = @fetch()

  parseDate:(date) ->
    moment(date)

  fromNow: ->
    @parseDate( @get 'created_at' ).fromNow()

  calendar: ->
    @parseDate( @get 'created_at' ).calendar()