class MusicNews.Collections.Submissions extends Backbone.Collection
  console.log("collections submissions, change url.")
  url: ->
    'submissions'
  model: MusicNews.Models.Submission
