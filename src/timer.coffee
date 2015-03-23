q = require 'q'
keypress = require 'keypress'
colors = require 'colors'
BlinkenHue = require './blinkenhue'
path = require 'path'

seconds = 1000

monitor = (b, total, warn) ->
  t = null
  start = null
  keypress process.stdin
  reset_t = () ->
    if t?
      clearTimeout t
    t = null
    start = null

  process.stdin.on 'keypress', (ch, key) ->
    if ch == 'q'
      console.log ""
      reset_t()
      b.do_reset().fin  ->
        process.exit 0
    if ch == 'c'
      reset_t()
      console.log '\nreset'.blue
      b.do_reset()
    if ch == ' '
      reset_t()
      start = new Date()
      console.log '\nstart'.blue, start.toISOString()
      t = setTimeout ->

        t = setTimeout ->
          t = null
          start = null
          console.log '\nalarm'.red
          b.do_alarm()
        , warn*seconds

        b.do_warn()
      , (total-warn)*seconds

      b.do_start()
      .done()

  process.stdin.setRawMode true
  process.stdin.resume

  setInterval ->
    if t and start
      d = total - Math.round((new Date() - start)/1000)
      ds = ("  " + d).slice(-3)
      if d > warn
        process.stdout.write "\r#{ds}".green
      else
        process.stdout.write "\r#{ds} warn".yellow
  , 50
  console.log 'READY'
  true

do_error = (er) ->
  console.log "\nERROR:".red, er

@run = (argv) ->
  argfile = null
  program = require 'commander'
    .option '-i --ip [address]', 'IP address'
    .option '-n --num [usernumber]', 'User number'
    .option '-w --warn [secs]', 'Warn with [secs] left'
    .option '-t --time [secs]', 'Total time to allow'
    .option '-f --file [filename]', 'filename for .json args'
    .parse process.argv

  if program.file
    f = path.join process.cwd(), program.file
    console.log "FILE: #{f}"
    argfile = require f

  warn = (argfile?.warn ? (program.warn ? 30) )* 1
  total = (argfile?.total ? (program.time ? 120)) * 1
  ip = (argfile?.ip ? (program.ip ? null))
  num = (argfile?.num ? (program.num ? null))

  b = new BlinkenHue ip, num
  b.start()
  .then (b) ->
      monitor b, total, warn
  .fail do_error
  .done()
