import express from 'express'

const app = express()
const PORT = 3117
const jsonBodyMiddleware = express.json()
app.use(jsonBodyMiddleware)

interface Coord {
    [key: string]: number
}

// interface SendActions {
//     [key: string]: number
// }

const coord:Coord = {
    hpX: 0,
    hpY: 0,
    cpX: 0,
    cpY: 0,
    F2X: 0,
    F3X: 0,
    SkillsYPos: 0,
    F10X: 0,
    F10Y: 0,
    chatX: 0,
    chatY: 0,
    fishWindowFromX: 0,
    fishWindowEndX: 0,
    fishWindowCenter: 0,
    fishWindowY: 0,
    barFromX: 0,
    barFromY: 0
}

// const sendActions:SendActions = {

// }

// app.get('/test', (req, res) => {
//     // Варианты
//     res.json(variable)
//     res.sendStatus(400)
//     res.status(201).json(variable)
// })

app.post('/initCoords', (req, res) => {
    coord.hpX = req.body.hpX
    coord.hpY = req.body.hpY
    coord.cpX = req.body.cpX
    coord.cpY = req.body.cpY
    coord.F2X = req.body.F2X
    coord.F3X = req.body.F3X
    coord.SkillsYPos = req.body.SkillsYPos
    coord.F10X = req.body.F10X
    coord.F10Y = req.body.F10Y
    coord.chatX = req.body.chatX
    coord.chatY = req.body.chatY

    console.log('Received init coordinates')
    console.log(coord)
    res.sendStatus(200)
})

app.post('/fishingWindow', (req, res) => {
    coord.fishWindowFromX = req.body.fishWindowFromX
    coord.fishWindowEndX = req.body.fishWindowEndX
    coord.fishWindowCenter = req.body.fishWindowCenter
    coord.fishWindowY = req.body.fishWindowY
    coord.barFromX = req.body.barFromX
    coord.barFromY = req.body.barFromY

    console.log('Received fishing window coordinates')
    console.log(coord)
    res.sendStatus(200)
})

app.listen(PORT, () => {
    console.log(`Backend started on port ${PORT}`)
})