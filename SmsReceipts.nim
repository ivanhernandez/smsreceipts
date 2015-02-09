#
# heroku create --stack cedar --buildpack https://github.com/vic/heroku-buildpack-nim.git

import jester, asyncdispatch, htmlgen, ropes

const
    buffer_size = 100
    MIME = "application/json"

type
    Responses = array[0..buffer_size, string]

var
    responses : Responses
    index : int = 0
    count : int = 0
    total : int = 0


proc json(table: StringTableRef): string =
    var
        first = true
        output = rope("[")

    for kv in table.pairs():
        if first:
            first = false
        else:
            output = output & ", "

        output = output & "{\"" & kv.key & "\": \"" & kv.value & "\"}"

    output = output & "]"
    $output

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

        resp(output & "]}", MIME)

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
                                "\", \"params\": " &
                                json(request.params) &
                                " }"

        resp("Ok", MIME)

    delete "/":
        var
            removed = count

        index = 0;
        count = 0;

        resp("{ \"removed\": " & $removed & " }", MIME)

runForever()
