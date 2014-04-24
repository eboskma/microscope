@Posts = new Meteor.Collection 'posts'

@Posts.allow
  insert: (userId, doc) -> !!userId
  update: ownsDocument
  remove: ownsDocument

@Posts.deny
  update: (userId, post, fieldNames) -> (_.without(fieldNames, 'url', 'title', 'message').length > 0)
  
Meteor.methods
  post: (postAttributes) ->
    user = Meteor.user()
    duplicatePost = Posts.findOne
      url: postAttributes.url
    
    if !user
      throw new Meteor.Error 401, 'You need to sign in to post new stories.'
    
    if !postAttributes.title
      throw new Meteor.Error 422, 'Please fill in a headline.'
    
    if postAttributes.url && duplicatePost
      throw new Meteor.Error 302, 'This link has already been posted.', duplicatePost._id
    
    post = _.extend _.pick(postAttributes, 'url', 'message'),
      title: postAttributes.title + (if @isSimulation then '*' else '')
      userId: user._id
      author: user.username
      submitted: new Date().getTime()
      commentsCount: 0
    
    postId = Posts.insert post