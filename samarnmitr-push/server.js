let path = require('path')
let express = require('express')
let app = express()
let io = require('socket.io')()

app.use(express.static(path.join(__dirname, 'public')))

// receive and push

// this is freaking insecure but it is just for temporary
app.get('/publish', (req, res, next) => {
  let counter = req.query.counter
  let items = JSON.parse(req.query.items)
  console.log(counter, items)
  for (let key in items) {
    io.to(key).emit('push', {
      counter: counter,
      item: items[key].name,
      quantity: items[key].quantity
    })
  }
  res.end()
})

// connect and register

io.on('connection', (socket) => {
  socket.on('subscribe', data => {
    data.forEach(item => {
      socket.join(item)
    })
  })
})

// listen

let port = process.env.PORT || 3000
let server = app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
io.attach(server)
console.log('Attached socket.io')
