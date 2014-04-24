Template.postEdit.helpers
  post: -> Posts.findOne @_id
  
Template.postEdit.events
  'submit form': (e) ->
    e.preventDefault()
    
    # currentPostId = Session.get('currentPostId')
    currentPostId = @_id
    postProperties = 
      url: $(e.target).find('[name="url"]').val()
      title: $(e.target).find('[name="title"]').val()
      message: $(e.target).find('[name="message"]').val()
    
    Posts.update currentPostId, { $set: postProperties }, 
      (error) ->
        if error?
          Errors.throw error.reason
        else
          Router.go 'postPage', _id: currentPostId 
  
  'click .delete': (e) ->
    e.preventDefault()
    
    if confirm('Delete this post?')
      currentPostId = @_id
      Posts.remove currentPostId
      Router.go 'postsList'