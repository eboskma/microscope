POST_HEIGHT = 80
Positions = new Meteor.Collection(null)

Template.postItem.helpers
  domain: ->
    anchor = document.createElement 'a'
    anchor.href = this.url
    anchor.hostname
  ownPost: -> @userId == Meteor.userId()
  upvotedClass: ->
    userId = Meteor.userId()
    
    if userId
      if !_.include(this.upvoters, userId)
        return 'upvotable'
      else
        return 'upvoted'
    else
      return 'disabled'
  attributes: ->
    post = _.extend({}, Positions.findOne(postId: @_id), this);
    newPosition = post._rank * POST_HEIGHT
    attributes = 
      class: 'post'
    
    if post.position?
      delta = post.position - newPosition
      attributes.style = "top: #{delta}px;"
      if delta == 0
        attributes.class = 'post animate'
    
    Meteor.setTimeout ->
      Positions.upsert
        postId: post._id
      ,
        $set: 
          position: newPosition
    
    attributes

Template.postItem.events
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', @_id

# Template.postItem.rendered = ->
#   rank = @data._rank
#   $this = $(@firstNode)
#   postHeight = 80
#   newPosition = rank * postHeight
#   
#   if @currentPosition?
#     previousPosition = @currentPosition
#     delta = previousPosition - newPosition
#     $this.css 'top', "#{delta}px"
#   
#   Meteor.defer =>
#     @currentPosition = newPosition
#     $this.css 'top', '0px'
