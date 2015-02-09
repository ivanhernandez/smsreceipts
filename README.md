
# SmsReceipts

This is a prototype of an application for catching SMS Receipts from globalSMS.

It is also a grat example of how a simple REST API can be done in minutes with
[Nim](http://nim-lang.org)
language and
[Jester](https://github.com/dom96/jester)
(and deploy it to [Heroku](https://www.heroku.com/) after some more minutes).

This application is based on [Getting Started with Clojure](https://devcenter.heroku.com/articles/getting-started-with-clojure) article - check it out.

This app was created thanks to the [buildpack](https://github.com/vic/heroku-buildpack-nim)
created by [Victor Hugo Borja](http://twitter.com/vborja) (he also provides an
[example](https://github.com/vic/nim-heroku-example) of its usage).

## Running Locally

Make sure you have [Nim](http://nim-lang.org)
correctly installed (you need at least 0.10.0 version) and its related
package manaher, [Nimble](https://github.com/nim-lang/nimble).

Also, you must install the [Heroku Toolbelt](https://toolbelt.heroku.com/).
It is possible to do almost all the work with [Git](http://git-scm.com/)
and Heroku's Dashboard, but you need to use the toolbelt for the ``create``
command (I don't believe is possible to bind a
[buildpack](https://devcenter.heroku.com/articles/buildpacks) to an application
 from the Dashboard)

Now you can get the app running locally with:

```sh
$ git clone https://github.com/ivanhernandez/smsreceipts.git
$ cd smsreceipts
$ nimble build
$ ./SmsReceipts
```

Your app should now be running on [localhost:5000](http://localhost:5000/),
unless you changed the port by setting $PORT environment variable.

## Deploying to Heroku

```sh
$ heroku create --stack cedar-14 --buildpack https://github.com/vic/heroku-buildpack-nim.git
$ git push heroku master
$ heroku open
```

## License

All this work is released under
[MIT License](https://raw.githubusercontent.com/ivanhernandez/smsreceipts/master/LICENSE)
