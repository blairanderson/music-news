class MusicNews.Views.SubmissionsIndex extends Backbone.View
  className: 'submission-list'
  template: JST['shared/main']
  initialize:(args) ->
    @collection = args.collection
    @$el.html @template() 
    @target = $('div.body')

  render: ->
    @collection.deferred.done =>
      @collection.each (submission) =>
        view = new MusicNews.Views.SubmissionPartial(model: submission).render()
        @target.append view.$el
    this