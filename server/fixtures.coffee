if Posts.find().count() == 0
  now = new Date().getTime()
  
  tomId = Meteor.users.insert
    profile:
      name: 'Tom Coleman'
  tom = Meteor.users.findOne tomId
  
  sachaId = Meteor.users.insert
    profile: 
      name: 'Sacha Greif'
  sacha = Meteor.users.findOne sachaId
  
  
  postId = Posts.insert
    title: 'Introducing Telescope'
    userId: sacha._id
    author: 'Sacha Greif'
    url: 'http://sachagreif.com/introducing-telescope/'
    submitted: now - 7 * 3600 * 1000
    commentsCount: 2
    upvoters: []
    votes: 0
  
  Comments.insert
    postId: postId
    userId: tom._id
    author: tom.profile.name
    submitted: now - 5 * 3600 * 1000
    body: 'Interesting project Sacha, can I get involved?'
  
  Comments.insert
    postId: postId
    userId: sacha._id
    author: sacha.profile.name
    submitted: now - 3 * 3600 * 1000
    body: 'You sure can Tom!'
    
  Posts.insert
    title: 'Meteor'
    userId: tom._id
    author: 'Tom Coleman'
    url: 'http://meteor.com'
    submitted: now - 10 * 3600 * 1000
    commentsCount: 0
    upvoters: []
    votes: 0
  
  Posts.insert
    title: 'The Meteor Book'
    userId: tom._id
    author: 'Tom Coleman'
    url: 'http://themeteorbook.com'
    submitted: now - 12 * 3600 * 1000
    commentsCount: 0
    upvoters: []
    votes: 0
  

  for num in [1..10]
    do (num) ->
      Posts.insert
        title: "Test post #{num}"
        author: sacha.profile.name
        userId: sacha._id
        url: "https://www.google.com/?q=test-#{num}"
        submitted: now - num * 3600 * 1000
        commentsCount: 0
        upvoters: []
        votes: 0
