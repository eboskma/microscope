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
  postsLimit: ->
    parseInt(@params.postsLimit) || @increment
  findOptions: ->
    limit: @postsLimit()
    sort: [['submitted', 'desc']]
  waitOn: ->
    Meteor.subscribe 'posts', @findOptions()
  data: ->
    posts:
      Posts.find {}, @findOptions()

Router.map ->
  @route 'postsList', 
    path: '/:postsLimit?'
    controller: PostsListController
  
  @route 'postPage',
    path: '/posts/:_id'
    waitOn: -> Meteor.subscribe 'comments', @params._id
    data: -> Posts.findOne(@params._id)
  
  @route 'postSubmit', 
    path: '/submit'
  
  @route 'postEdit',
    path: '/posts/:_id/edit'
    data: -> Posts.findOne(@params._id)

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