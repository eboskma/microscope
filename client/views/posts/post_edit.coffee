Template.postEdit.helpers
  post: -> Posts.findOne @_id
  
Template.postEdit.events
  'submit form': (e) ->
    e.preventDefault()
    
    # current_post_id = Session.get('current_post_id')
    current_post_id = @_id
    post_properties = 
      url: $(e.target).find('[name="url"]').val()
      title: $(e.target).find('[name="title"]').val()
      message: $(e.target).find('[name="message"]').val()
    
    Posts.update current_post_id, { $set: post_properties }, 
      (error) ->
        if error?
          Errors.throw error.reason
        else
          Router.go 'postPage', _id: current_post_id 
  
  'click .delete': (e) ->
    e.preventDefault()
    
    if confirm('Delete this post?')
      current_post_id = @_id
      Posts.remove current_post_id
      Router.go 'postsList'