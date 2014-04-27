{spawn, exec}  = require 'child_process'
module.exports = (robot) ->
  robot.respond /deploy (.*)$/i , (msg) ->
    application = msg.match[1]

    projects = ["remp", "stbd", "casto"]

    if application in projects
      msg.send "--- Deploy Starting. #{application} project."
      msg.send "git clone..."

      exec "cd tmp && git clone git@github.com:hikarock/#{application}.git", (err, stdout, stderr) ->
        msg.send "git clone finished. Now deploying..."
        deploy(msg, application)
    else
      msg.send "--- Deploy failed. (Project name unmatched.)"

  deploy = (msg, app) ->
    exec "cd tmp/#{app} && bundle install --path vendor/bundle && bundle exec mina deploy", (err, stdout, stderr) ->
      if err
        msg.send "--- [Error!!] Deploy failed."
      else
        msg.send "--- Deploy finished."

