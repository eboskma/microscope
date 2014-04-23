@Comments = new Meteor.Collection 'comments'

Meteor.methods
  comment: (comment_attributes) ->
    user = Meteor.user()
    post = Posts.findOne comment_attributes.post_id
    
    if !user
      throw new Meteor.error 401, 'You need to log in to make comments.'
    
    if !comment_attributes.body
      throw new Meteor.error 422, 'Please write something.'
    
    if !comment_attributes.post_id
      throw new Meteor.error 422, 'You must comment on a post.'
    
    comment = _.extend _.pick(comment_attributes, 'post_id', 'body'),
      user_id: user._id
      author: user.username
      submitted: new Date().getTime()
    
    Comments.insert comment
    