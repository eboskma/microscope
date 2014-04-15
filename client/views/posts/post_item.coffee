Template.postItem.helpers
  domain: ->
    anchor = document.createElement 'a'
    anchor.href = this.url
    anchor.hostname
  ownPost: -> @userId == Meteor.userId()