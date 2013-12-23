class MusicNews.Collections.Submissions extends Backbone.Collection
  console.log("collections submissions, change url.")
  url: ->
    'feed'
  model: MusicNews.Models.Submission
