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
    sort: [['submitted', 'desc']]
  waitOn: ->
    Meteor.subscribe 'posts', @findOptions()
  posts: ->
    Posts.find {}, @findOptions()
  data: ->
    hasMore = @posts().count() == @limit()
    posts: @posts()
    nextPath: if hasMore then @route.path({ postsLimit: @limit() + @increment }) else null
    

Router.map ->
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: -> Meteor.subscribe 'comments', @params._id
    data: -> Posts.findOne(@params._id)
  
  @route 'postSubmit', 
    path: '/submit'
  
  @route 'postEdit',
    path: '/posts/:_id/edit'
    data: -> Posts.findOne(@params._id)
  
  @route 'postsList', 
    path: '/:postsLimit?'
    controller: PostsListController
  

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