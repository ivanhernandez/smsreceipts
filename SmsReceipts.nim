#
# heroku create --stack cedar --buildpack https://github.com/vic/heroku-buildpack-nim.git

import jester, asyncdispatch, htmlgen, os, strutils

const
    buffer_size = 100

type
    Responses = array[0..buffer_size, string]

var
    responses : Responses
    index : int = 0
    count : int = 0
    total : int = 0

var settings = newSettings()
if existsEnv("PORT"):
    settings.port = Port(parseInt(getEnv("PORT")))

routes:
    get "/":
        var
            output = "{ \"queries\": " & $total & ", \"lastReceipts\": [\n"
            i = index
            n = count

        while n > 0:
            while n > 0 and i < buffer_size:
                output = output & "\n" & responses[i]
                i = i + 1
                n = n - 1
                if n > 0:
                    output = output & ", "
            i = 0

        resp(output & "]}", "application/json")

    post "/":
        var item_index : int

        if count < buffer_size:
            item_index = count
            count = count + 1
        else:
            index = (index + 1) mod buffer_size
            if index > 0:
                item_index = index - 1
            else:
                item_index = buffer_size - 1

        total = total + 1

        responses[item_index] = "{ \"body\": \"" &
                                $request.body &
                                "\", \"params\": \"" &
                                $request.params &
                                "\" }"

        resp("Ok", "application/json")

runForever()
