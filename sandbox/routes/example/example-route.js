const Boom = require('boom')
const datefns = require('date-fns')

module.exports = [

  {
    method: 'GET',
    path: '/example',
    handler: (request) => {
      var is_successful = request.query["is_successful"];
      if (is_successful) {
        return {
          "data": "example data",
          "timestamp": datefns.format(Date.now(), "yyyy-MM-dd'T'HH:mm:ss+00:00")
        }
      }
      else {
        throw Boom.badRequest("Invalid params supplied")
      }
    }
  }

]
