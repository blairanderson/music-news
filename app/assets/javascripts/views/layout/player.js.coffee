class MusicNews.Views.Player extends Backbone.View
  id: 'music-player'
  template: JST['shared/player']
  initialize: ->
    _this = this
    @songs = MusicNews.App.collections.songs
    SC.initialize(client_id: "c024bdd48e9ecf014c71af406201f3a2");
    SC.whenStreamingReady ->
      console.log 'streaming ready'
      _this.updateCurrentTrack()
      debugger

  render: ->
    $(@el).html(this.template())
    this

  updateCurrentTrack: ->
    @getCurrentTrack() 
    
    $(@el).find('#playlist i.track').text("  now playing....")

    $("#currentTrack").text(@currentTrack.song.title);
    @currentTrack.song.source_url
    $("#currentTrack").append(nowplaying);
  getCurrentTrack: ->
    @currentTrack ||= @songs.first()
    @currentTrack
