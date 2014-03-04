class @mainControl extends RouteController
  layoutTemplate: 'layout'
  waiton: ->
    return Meteor.subscribe 'TestCollection'
  action: ->
    @render 'main'
    @render 'searchTemplate', to: 'searchYield'

Router.map ->
	@route 'main',
    path: '/'
    template: 'main'
    data:
      greeting: "Welcome to irtest! This is the main page. Go to search, and I'll go away because I was data pased by the 'main' route controller"
    controller: 'mainControl'

  @route 'search',
    path: '/search/:s?'
    template: 'searchTemplate'
    data: -> return searchTerm: if @params.s? then @param.s else 'no search!'
    controller: 'mainControl'

#Template.main.greeting = -> "Welcome to irtest."

Template.layout.events
  'click input': -> console.log "You pressed the button"
