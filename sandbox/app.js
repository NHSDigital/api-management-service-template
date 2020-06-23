'use strict'

const Hapi = require('@hapi/hapi')
const Path = require('path')
const Inert = require('inert')
const routes = require('./routes/example')

const init = async () => {
  const server = Hapi.server({
    port: 9000,
    host: '0.0.0.0',
    routes: {
      cors: true, // Won't run as Apigee hosted target without this
      files: {
        relativeTo: Path.join(__dirname, 'mocks')
      }
    }
  })

  await server.register(Inert)

  server.route(routes)

  await server.start()
  console.log('Server running on %s', server.info.uri)
}

process.on('unhandledRejection', (err) => {
  console.log(err)
  process.exit(1)
})

init()
