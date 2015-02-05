#
# heroku create --stack cedar --buildpack https://github.com/vic/heroku-buildpack-nim.git

import jester, asyncdispatch, htmlgen

routes:
    get "/":
        resp h1("Hello world")

runForever()
