class MusicNews.Collections.Songs extends Backbone.Collection
  model: MusicNews.Models.Song

  url: ->
    'songs'

  initialize: (options) ->
    options = options || {}
    filter_sort = {}

    _.extend(filter_sort, sort: options.sort ) if options.sort
    _.extend(filter_sort, filter: options.filter ) if options.filter

    if options.fetch
      @deferred = @fetch
        reset: true
        data: $.param(filter_sort)
        fetch: false
    else
      @deferred = $.Deferred().resolveWith()

  parse: (response) ->
    @pagingData = response.pagingData
    response.songs
