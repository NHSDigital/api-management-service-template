const fs = require('fs')

module.exports = {
  exampleData: JSON.parse(fs.readFileSync('mocks/ExampleData.json'))
}
