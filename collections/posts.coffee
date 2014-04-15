@Posts = new Meteor.Collection 'posts'

@Posts.allow
  insert: (user_id, doc) -> !!user_id
  update: ownsDocument
  remove: ownsDocument

@Posts.deny
  update: (user_id, post, fieldNames) -> (_.without(fieldNames, 'url', 'title', 'message').length > 0)
  
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
    
    post = _.extend _.pick(post_attributes, 'url', 'message'),
      title: post_attributes.title + (if @isSimulation then '*')
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
    
    if !@isSimulation
      Future = Npm.require 'fibers/future'
      future = new Future()
      Meteor.setTimeout ->
        future.return()
      , 5000
      future.wait()
      
    post_id = Posts.insert post