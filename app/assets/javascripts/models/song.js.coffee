class MusicNews.Models.Song extends Backbone.Model
  defaults:
    percent: 0

  progressPercent:->
    "width: #{@get('percent')}%;"

  progressPercentRound: ->
    "#{Math.floor @get('percent')}%"

  url: ->
    "/songs/#{@id}"

  parseDate:(date) ->
    moment(date)

  fromNow: ->
    @parseDate( @get 'created_at' ).fromNow()

  calendar: ->
    @parseDate( @get 'created_at' ).calendar()
