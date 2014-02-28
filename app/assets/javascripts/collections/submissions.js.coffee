class MusicNews.Collections.Submissions extends Backbone.Collection
  model: MusicNews.Models.Submission

  initialize: ->
    @deferred = @fetch()

  url: ->
    '/submissions'

  parse: (response) ->
    @pagingData = response.pagingData
    response.submissions
