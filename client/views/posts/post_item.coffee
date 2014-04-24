Template.postItem.helpers
  domain: ->
    anchor = document.createElement 'a'
    anchor.href = this.url
    anchor.hostname
  ownPost: -> @userId == Meteor.userId()
  upvotedClass: ->
    userId = Meteor.userId()
    
    if userId && !_.include(this.upvoters, userId)
      return 'upvotable'
    else
      return 'upvoted'

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id