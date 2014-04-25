Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    [
      Meteor.subscribe 'notifications'
    ]
  
@PostsListController = RouteController.extend
  template: 'postsList'
  increment: 5
  limit: ->
    parseInt(@params.postsLimit) || @increment
  findOptions: ->
    limit: @limit()
    sort: @sort
  waitOn: ->
    Meteor.subscribe 'posts', @findOptions()
  posts: ->
    Posts.find {}, @findOptions()
  data: ->
    hasMore = @posts().count() == @limit()
    posts: @posts()
    # nextPath: if hasMore then @route.path({ postsLimit: @limit() + @increment }) else null
    nextPath: @nextPath()
    
@NewPostsListController = PostsListController.extend
  sort: [['submitted', 'desc'], ['_id', 'desc']]
  nextPath: ->
    Router.routes.newPosts.path
      postsLimit: @limit() + @increment

@BestPostsListController = PostsListController.extend
  sort: [['votes', 'desc'],['submitted', 'desc'], ['_id', 'desc']]
  nextPath: ->
    Router.routes.bestPosts.path
      postsLimit: @limit() + @increment
    
Router.map ->
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: -> 
      [
        Meteor.subscribe 'singlePost', @params._id
        Meteor.subscribe 'comments', @params._id
      ]
    data: -> Posts.findOne(@params._id)
  
  @route 'postSubmit', 
    path: '/submit'
    progress: 
      enabled: false
  
  @route 'postEdit',
    path: '/posts/:_id/edit'
    waitOn: -> 
      [
        Meteor.subscribe 'singlePost', @params._id
        Meteor.subscribe 'comments', @params._id
      ]
    data: -> Posts.findOne(@params._id)
  
  @route 'newPosts', 
    path: '/new/:postsLimit?'
    controller: NewPostsListController
  
  @route 'bestPosts', 
    path: '/best/:postsLimit?'
    controller: BestPostsListController
  
  @route 'home', 
    path: '/:postsLimit?'
    controller: NewPostsListController

requireLogin = (pause) ->
  if !Meteor.user()
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'
    pause()

Router.onBeforeAction requireLogin, 
  only: 'postSubmit'
Router.onBeforeAction -> Errors.clearSeen()