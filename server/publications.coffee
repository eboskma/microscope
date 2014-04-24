Meteor.publish 'posts', (sort, limit) -> 
  Posts.find {},
    sort: sort
    limit: limit

Meteor.publish 'singlePost', (id) -> id && Posts.find(id)
  
Meteor.publish 'comments', (postId) -> 
  Comments.find
    postId: postId

Meteor.publish 'notifications', -> 
  Notifications.find
    userId: @userId