$ = require("jquery")
React = require("react")
ReactDOM = require('react-dom')

Main = require("./flux/views/Main")
Category = require("./flux/views/Category")

ReactRouter = require('react-router')
{Router, Route} = ReactRouter

$ ->
  ReactDOM.render(
    `(
      <Router>
        <Route path="/" component={Main}></Route>
        <Route path="category" component={Category}/>
      </Router>
    )`,
    document.getElementById("app")
  )

