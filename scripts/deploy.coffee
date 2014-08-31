cronJob = require('cron').CronJob

{spawn, exec}  = require 'child_process'
module.exports = (robot) ->
  robot.respond /deploy (.*)$/i , (msg) ->
    application = msg.match[1]

    projects = ["remp", "stbd", "casto", "mo-api"]

    if application in projects
      msg.send "╭( ･ㅂ･)و＜  Deploy Starting. #{application} project."
      msg.send "git clone..."

      exec "cd tmp && git clone git@github.com:hikarock/#{application}.git", (err, stdout, stderr) ->
        msg.send "git clone finished. Now deploying..."
        deploy(msg, application)
    else
      msg.send "--- Deploy failed. (Project name unmatched.)"

  robot.respond /restart (.*)$/i, (msg) ->
    application = msg.match[1]
    projects = ["remp", "stbd"]

    if application in projects
      msg.send "╭( ･ㅂ･)و＜ #{application} - Unicorn restart"
      restart(application)

  deploy = (msg, app) ->
    exec "cd tmp/#{app} && bundle install --path vendor/bundle && bundle exec mina deploy", (err, stdout, stderr) ->
      if err
        msg.send "╭( ･ㅂ･)و＜  [Error!!] Deploy failed."
      else
        msg.send "╭( ･ㅂ･)و＜  Deploy finished."

  cleanup = (pjName) ->
    exec "cd tmp/#{pjName} && bundle exec mina deploy:cleanup", (err, stdout, stderr) ->
      if err
        robot.send {room:'remp_team'}, "╭( ･ㅂ･)و＜ #{pjName} container deploy:cleanup failed....."
      else
        robot.send {room:'remp_team'}, "╭( ･ㅂ･)و＜ #{pjName} container deploy:cleanup success!!"

  restart = (pjName) ->
    exec "cd tmp/#{pjName} && bundle exec mina unicorn:graceful_restart", (err, stdout, stderr) ->
      if err
        robot.send {room:'remp_team'}, "╭( ･ㅂ･)و＜ #{pjName} container unicorn:graceful_restart failed....."
      else
        robot.send {room:'remp_team'}, "╭( ･ㅂ･)و＜ #{pjName} container unicorn:graceful_restart  success!!"


  new cronJob('04 04 * * *', () ->
    projects = ["remp", "stbd", "casto", "mo-api"]

    for pj,i in projects
      cleanup(pj)

  ).start()

  new cronJob('05 05 * * *', () ->
    projects = ["remp", "stbd"]

    for pj,i in projects
      restart(pj)

  ).start()
