import * as http from 'http'

interface DB {
    [key: string]: number
}

const DB:DB = {
    hpHor: 0,
    hpVer: 0,
    cpHor: 0,
    cpVer: 0,
    F2Hor: 0,
    F3Hor: 0,
    SkillsVerPos: 0,
    F10Hor: 0,
    F10Ver: 0,
    chatHor: 0,
    chatVer: 0
}

const server = http.createServer(( request:http.IncomingMessage, response:http.ServerResponse ) => {

    if (request.method === 'GET') {

        switch (request.url) {
        case '/main':
            break
        case '/keyboard':
            break
        case '/hp':
            break
        case '/progressbar':
            break
        case '/chat':
            break
        }

    } else if (request.method === 'POST') {

        switch (request.url) {
        case '/main':
            break
        case '/keyboard':
            break
        case '/hp':
            break
        case '/progressbar':
            break
        case '/chat':
            break
        }

    }

    response.write('test')
    response.end()
})

server.listen(3117)