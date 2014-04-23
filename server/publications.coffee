Meteor.publish 'posts', -> Posts.find()
  
Meteor.publish 'comments', (post_id) -> 
  Comments.find
    post_id: post_id