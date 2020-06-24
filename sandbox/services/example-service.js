const fs = require('fs')

module.exports = {
  exampleData: JSON.parse(fs.readFileSync(__dirname + '/../mocks/ExampleData.json'))
}
