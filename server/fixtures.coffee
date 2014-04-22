if Posts.find().count() == 0
  now = new Date().getTime()
  
  tom_id = Meteor.users.insert
    profile:
      name: 'Tom Coleman'
  tom = Meteor.users.findOne tom_id
  
  sacha_id = Meteor.users.insert
    profile: 
      name: 'Sacha Greif'
  sacha = Meteor.users.findOne sacha_id
  
  
  post_id = Posts.insert
    title: 'Introducing Telescope'
    user_id: sacha._id
    author: 'Sacha Greif'
    url: 'http://sachagreif.com/introducing-telescope/'
    submitted: now - 7 * 3600 * 1000
  
  Comments.insert
    post_id: post_id
    user_id: tom._id
    author: tom.profile.name
    submitted: now - 5 * 3600 * 1000
    body: 'Interesting project Sacha, can I get involved?'
  
  Comments.insert
    post_id: post_id
    user_id: sacha._id
    author: sacha.profile.name
    submitted: now - 3 * 3600 * 1000
    body: 'You sure can Tom!'
    
  Posts.insert
    title: 'Meteor'
    user_id: tom._id
    author: 'Tom Coleman'
    url: 'http://meteor.com'
    submitted: now - 10 * 3600 * 1000
  
  Posts.insert
    title: 'The Meteor Book'
    user_id: tom._id
    author: 'Tom Coleman'
    url: 'http://themeteorbook.com'
    submitted: now - 12 * 3600 * 1000
    