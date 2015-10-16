React = require("react")
ReactRouter = require('react-router')
{Link} = ReactRouter

Store = require("../stores/Store")
Actions = require("../actions/Actions")


Category = React.createClass({

  render: ->
    return `(
        <div className="app">
          <Link to="/">Go main</Link>
          ZE nome
        </div>
    )`
})

module.exports = Category
