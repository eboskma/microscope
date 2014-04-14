@Posts = new Meteor.Collection 'posts'

@Posts.allow
  insert: (user_id, doc) -> !!user_id
  
Meteor.methods
  post: (post_attributes) ->
    user = Meteor.user()
    duplicate_post = Posts.findOne
      url: post_attributes.url
    
    if !user
      throw new Meteor.Error 401, 'You need to sign in to post new stories.'
    
    if !post_attributes.title
      throw new Meteor.Error 422, 'Please fill in a headline.'
    
    if post_attributes.url && duplicate_post
      throw new Meteor.Error 302, 'This link has already been posted.', duplicate_post._id
    
    post = _.extend _.pick(post_attributes, 'url', 'title', 'message'),
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    
    post_id = Posts.insert post