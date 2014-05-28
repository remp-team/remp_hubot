# Description:
#   REMP status.
#
# Commands:
#   hubot status - Reply with application status.

cronJob = require('cron').CronJob
step = require('step')

module.exports = (robot) ->
  robot.respond /status (.*)$/i , (msg) ->
    projects = ["remp"]
    application = msg.match[1]

    if application in projects
      msg.send "Application status: #{application}"
      request = msg.http('http://www.remp.jp/api/status').get()

      request (err, res, body) ->
        if(!err)
          json = JSON.parse body
          msg.send "再生回数: #{json.today_play_count}"
          msg.send "検索回数: #{json.today_search_count}"

  new cronJob('0 */4 * * *', () ->
    http = robot.http('http://www.remp.jp/api/status').get()
    http (err, res, body) ->
      if(!err)
        json = JSON.parse body

        step(
          () ->
            robot.send {room:'remp_team'}, "--- REMP status ---"
            setTimeout @, 1000
            return
          () ->
            robot.send {room:'remp_team'}, "再生回数: #{json.today_play_count}"
            setTimeout @, 1000
            return
          () ->
            robot.send {room:'remp_team'}, "検索回数: #{json.today_search_count}"
            return
        )
  ).start()
