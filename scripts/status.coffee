# Description:
#   REMP status.
#
# Commands:
#   hubot status - Reply with pong

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

