## Hubot
### これは何？
- このリポジトリはREMPプロジェクトで利用しているHubotを管理するリポジトリです。
- HubotはREMPチームで利用しているチャットサービス上に常駐しています。


### Usage
#### REMPチームで運用中のアプリのデプロイ
チャットサービス上にいるユーザであれば、サービス上で以下のコマンドを呼びかけることでGithubで管理されているmasterリポジトリの内容をアプリケーションコンテナにデプロイできます。

```
Hubot> hubot deploy (remp|stbd|casto)
```

#### アプリケーションパラメータ取得
- チャットサービス上にいるユーザであれば、アプリケーションのパラメータを取得することができます。
 - 現在のところREMPのみ

```
Hubot> hubot status remp
Hubot> Application status: remp
Hubot> 再生回数: ***
Hubot> 検索回数: ***
```

#### Hubotコマンド

```
Hubot> hubot help

Hubot <user> doesn't have <role> role - Removes a role from a user
Hubot <user> has <role> role - Assigns a role to a user
Hubot <user> is a badass guitarist - assign a role to a user
Hubot <user> is not a badass guitarist - remove a role from a user
Hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.
Hubot die - End Hubot process
Hubot echo <text> - Reply back with <text>
Hubot fake event <event> - Triggers the <event> event for debugging reasons
Hubot help - Displays all of the help commands that Hubot knows about.
Hubot help <query> - Displays all help commands that match <query>.
Hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
Hubot map me <query> - Returns a map view of the area returned by `query`.
Hubot mustache me <query> - Searches Google Images for the specified query and mustaches it.
Hubot mustache me <url> - Adds a mustache to the specified URL.
Hubot ping - Reply with pong
Hubot pug bomb N - get N pugs
Hubot pug me - Receive a pug
Hubot show storage - Display the contents that are persisted in the brain
Hubot show users - Display all users that Hubot knows about
Hubot the rules - Make sure Hubot still knows the rules.
Hubot time - Reply with current time
Hubot translate me <phrase> - Searches for a translation for the <phrase> and then prints that bad boy out.
Hubot translate me from <source> into <target> <phrase> - Translates <phrase> from <source> into <target>. Both <source> and <target> are optional
Hubot what role does <user> have - Find out what roles are assigned to a specific user
Hubot who has admin role - Find out who's an admin and can assign roles
Hubot who is <user> - see what roles a user has
Hubot youtube me <query> - Searches YouTube for the query and returns the video embed link.
```


### このHubot自体のデプロイ方法
manage001コンテナへ以下のコマンドでデプロイされます。

```
$ bundle exec mina deploy
```

