const path = require('path')
const fs = require('fs')
const { Elm } = require('./dist/elm.js')

const app = Elm.Main.init({
  flags: [
    "Dashboard",
    "AboutUs",
    "Careers",
    "NotFound"
  ]
})

app.ports.log.subscribe(str =>
  fs.writeFileSync(
    path.join(__dirname, 'dist', 'Route.elm'),
    str
  )
)