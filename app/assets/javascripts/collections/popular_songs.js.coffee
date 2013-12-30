class MusicNews.Collections.PopularSongs extends Backbone.Collection
  url: ->
    url = window.location.origin + '/songs?sort=popular'
    console.log("popular songs url", url)
    url
  model: MusicNews.Models.Song
