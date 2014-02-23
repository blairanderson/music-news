class MusicNews.Collections.Songs extends Backbone.Collection
  model: MusicNews.Models.Song

  initialize: (options) ->
    options = options || {}
    filter_sort = {}
    
    _.extend(filter_sort, sort: options.sort ) if options.sort
    _.extend(filter_sort, filter: options.filter ) if options.filter

    if options.fetch  
      @deferred = @fetch({data: $.param(filter_sort)})
    else
      @deferred = $.Deferred()
      @deferred.resolve()


  parse: (response) -> 
    response.songs

  url: ->
    'songs'
