class MusicNews.Collections.Submissions extends Backbone.Collection
  url: ->
    url = window.location.origin + '/submissions'
    console.log('url', url)
    url
  model: MusicNews.Models.Submission

