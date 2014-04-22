Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    [
      Meteor.subscribe 'posts'
      Meteor.subscribe 'comments'
    ]
  
Router.map ->
  @route 'postsList', 
    path: '/'
  
  @route 'postPage',
    path: '/posts/:_id'
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
Router.onBeforeAction -> Errors.clear_seen()