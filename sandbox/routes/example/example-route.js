const Boom = require('boom')
const exampleService = require('../../services/example-service')
const datefns = require('date-fns')

module.exports = [

  {
    method: 'GET',
    path: '/Example',
    handler: (request) => {
      var is_successful = request.query["is_successful"];
      if (is_successful) {
        return {
          "timestamp": datefns.format(Date.now(), "yyyy-MM-dd'T'HH:mm:ss+00:00"),
          "data": exampleService.exampleData
        }
      }
      else {
        throw Boom.badRequest("Invalid params supplied")
      }
    }
  }

]
