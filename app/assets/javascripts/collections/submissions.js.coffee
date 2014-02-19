class MusicNews.Collections.Submissions extends Backbone.Collection
  initialize: ->
    @deferred = @fetch()

  url: ->
    '/submissions'
    
  model: MusicNews.Models.Submission

