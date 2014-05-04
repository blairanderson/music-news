class MusicNews.Session extends Backbone.Model
  url: ->
    @options.host + "/session"

  defaults:
    auth: 0
    updated: 0

  state: false
  options:
    local: true
    remote: true
    persist: false
    host: ""

  initialize: (model, options) ->
    options = options or {}
    @options = _.extend(@options, options)

    # replace the whole URL if supplied
    @url = options.url  unless _.isUndefined(options.url)

    @deferred = @fetch()

    # event binders
    @bind "change", @update
    @bind "error", @error
    @on "logout", @logout

  parse: (data) ->
    user = data.user
    if user && user.keychain
      user.api_secret = user.keychain.api_secret
      user.api_token = user.keychain.api_token
      delete user.keychain
    user || data

  update: =>
    unless @state
      @state = true
      @trigger "loaded"

  logout: (options) =>
    self = this
    options = options or {}
    # delete local version
    @store.clear "session"
    # notify remote
    @destroy
      wait: true
      success: (model, resp) ->
        model.clear()
        model.id = null
        self.set auth: false
        self.set _csrf: resp._csrf  if resp and resp._csrf
        window.location.reload()
      error: (model, req, options, error) ->
        console.log req

  sessionStorage:
    get: (name) ->
      sessionStorage.getItem name

    set: (name, val) ->
      # validation first?
      sessionStorage.setItem name, val
    check: (name) ->
      not sessionStorage.getItem(name)?
    clear: (name) ->
      # actually just removing the session...
      sessionStorage.removeItem name

  localStorage:
    get: (name) ->
      localStorage.getItem name
    set: (name, val) ->
      # validation first
      localStorage.setItem name, val
    check: (name) ->
      not localStorage.getItem(name)?
    clear: (name) ->
      # actually just removing the session...
      localStorage.removeItem name
