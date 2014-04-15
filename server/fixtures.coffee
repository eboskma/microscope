if Posts.find().count() == 0
  Posts.insert
    title: 'Introducing Telescope'
    author: 'Sacha Greif'
    url: 'http://sachagreif.com/introducing-telescope/'
    submitted: new Date(2014, 2, 10).getTime()
  
  Posts.insert
    title: 'Meteor'
    author: 'Tom Coleman'
    url: 'http://meteor.com'
    submitted: new Date(2014, 2, 2).getTime()
  
  Posts.insert
    title: 'The Meteor Book'
    author: 'Tom Coleman'
    url: 'http://themeteorbook.com'
    submitted: new Date(2014, 1, 23).getTime()
    