class MusicNews.Models.FeatureRequest extends Backbone.Model
  features:
    'default':
      'content': "This isn't available yet, but we put it here to see if people are interested in it. "
      'title' : 'Are you interested in this feature?'
    'submitSong':
      'content': 'Would you like to submit a song?'
      'title' : 'Interested in Submitting a song?'
    'loginRequired':
      'content': 'WOOOT, Sorry, you must login for that!'
      'title' : 'Login Required!'

  initialize: (@name) ->
    @name = @name || 'default'
    @content = @features[@name]['content']
    @title   = @features[@name]['title']

  modalOptions: ->
    options =
      content:    @content
      title:      @title
      okText:     'GREAT!'
      cancelText: 'Nevermind...'
      animate:    true
    options
