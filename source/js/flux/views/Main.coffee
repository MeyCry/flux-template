React = require("react")

Store = require("../stores/Store")
Actions = require("../actions/Actions")

Main = React.createClass({

  getInitialState: ->
    {
      countClick: Store.getCountClick()
    }
  handleClick: (ev) ->
    Actions.clickOnBtn(++@state.countClick)

  newState: ->
    @setState({
      countClick: Store.getCountClick()
    })

  componentWillMount: ->
    Store.addChangeListener(@newState)

  render: ->
    return `(
      <div className="app">
        <span>{this.state.countClick}</span>
        <button onClick={this.handleClick}>click me</button>
      </div>
    )`
})

module.exports = Main
