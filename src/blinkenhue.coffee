q = require 'q'
hapi = require 'node-hue-api'
colors = require 'colors'

blue = 46920
red = 65280
yellow = 12750
green = 25500

do_error = (er) ->
  console.log "\nERROR:".red, er

module.exports = class BlinkenHue

  constructor: (@ip, @num) ->
    @hu = null
    @pending = false

  _connect: ()->
    @hu = new hapi.HueApi @ip, @num, 1000
    @hu.config().then (c) =>
      if !c.ipaddress? or (c.portalconnection != 'connected')
        console.log 'Bad config:', c
        process.exit 1
      @

  _getIP: ->
    if @ip?
      q.resolve @ip
    else
      hapi.nupnpSearch().then (r) =>
        @ip = r[0].ipaddress
        console.log "IP: #{@ip}"
        @ip

  start: ->
    @_getIP().then () =>
      if @num?
          @_connect()
      else
        h = new hapi.HueApi()
        h.registerUser(addr).then (user) ->
          console.log "USER: #{user}"
          @num = user
          @_connect()

  set_state: (state) ->
    if @pending
      do_error 'Overlapped'
      q.reject 'Overlapped'
    else
      @pending = true
      @hu.setGroupLightState 0, state
      .fail (er) ->
        do_error er
      .fin =>
        # wait 50ms after finish to allow starting the next
        q.timeout(50).then =>
          @pending = false

  do_reset: ->
    @set_state hapi.lightState.create().transitionInstant().off()

  do_start: ->
    @set_state hapi.lightState.create().hue(green).bri(64).sat(255).transitionInstant().on()

  do_warn: ->
    @set_state hapi.lightState.create().hue(yellow).bri(128).sat(255).transitiontime(20).on()

  do_alarm: ->
    @set_state hapi.lightState.create().hue(red).bri(255).sat(255).transitionInstant().alert('select').on()
