#!/usr/bin/env node

/// <reference path="./typings/tsd.d.ts" />

const http = require("http")
const fs = require("fs")

function getParameters(url) {
    var parameters = {}

    var paramstr = url.match(/\?.*$/) + ""
    paramstr = paramstr.substring(1, paramstr.length)
    console.log(paramstr)
    var arr = paramstr.split("&")
    for (var i in arr) {
        var keyvalue = arr[i].split("=")
        parameters[keyvalue[0]] = keyvalue[1]
    }

    return parameters
}

function getHostIp() {
    const os = require("os")
    var a = os.networkInterfaces()
    var b = a["en0"]
    for (var i in b) {
        if (b[i].family == "IPv4") {
            console.log(b[i].address)
            return b[i].address
        }
    }
}

const server = http.createServer((req, resp) => {

    var parameters = getParameters(req.url)

    var temp = fs.readFileSync("pac.js", "utf-8")
    temp = temp.replace("[template]", getHostIp())

    if (req.url.indexOf("all") > 0) {
        temp = temp.replace("var allProxy = 0;", "var allProxy = 1;")
    }

    resp.write(temp)
    resp.end()

})

server.listen(8990)