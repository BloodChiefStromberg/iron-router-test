helper =  ->
  console.log @params.s
  @stop

class @mainControl extends RouteController
  layoutTemplate: 'layout'
  waiton: ->
    return Meteor.subscribe 'TestCollection'
  before: ->
    console.log 'should stop after this'
    @stop
  action: ->
    @render 'main'
    @render 'searchTemplate', to: 'searchYield'
    console.log this

Router.map ->
  @route 'something',
    path: '/something'
    where: 'server'
    before: ->
      console.log @
    action: ->
      @response.writeHead 200, {'Content-Type': 'text/html'}
      @response.end 'hello from server!'

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
    data: -> return searchTerm: if @params.s? then @params.s else 'no search!'
    before: ->
      helper.call @
    controller: 'mainControl'


