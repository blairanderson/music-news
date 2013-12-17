class MusicNews.Collections.Submissions extends Backbone.Collection
  console.log("collections submissions, change url.")
  url: ->
    if MusicNews.Helpers.env.dev()
      'http://new.seainhd.com/feed.json'
    else
      'feed.json'
  model: MusicNews.Models.Submission
