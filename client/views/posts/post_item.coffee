Template.postItem.helpers
  domain: ->
    anchor = document.createElement 'a'
    anchor.href = this.url
    anchor.hostname
  ownPost: -> @userId == Meteor.userId()

Template.postItem.events
  'click .upvote': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id