class MusicNews.Collections.Favorites extends Backbone.Collection
  model: MusicNews.Models.Favorite

  url: ->
    'user_song_tags'

  initialize: (options) ->
    options = options || {}

    @session = options.session
    @api_secret_token = {api_token: @session.get('api_token'), api_secret: @session.get('api_secret')}

    if options.fetch
      @deferred = @fetch
        data: $.param @api_secret_token
        reset: true
        fetch: false
    else
      @deferred = $.Deferred().resolveWith()

  create: (model, options) ->
    options ||= {}
    new_options = _.extend options,
      wait: true,
      data: $.param _.extend @api_secret_token, {user_song_tag: model.attributes}
    super(model, new_options)
