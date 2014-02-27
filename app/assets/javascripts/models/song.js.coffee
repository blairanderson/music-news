class MusicNews.Models.Song extends Backbone.Model

  url: ->
    "/songs/#{@id}"

  parseDate:(date) ->
    moment(date)

  fromNow: ->
    @parseDate( @get 'created_at' ).fromNow()

  calendar: ->
    @parseDate( @get 'created_at' ).calendar()