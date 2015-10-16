$ = require("jquery")
React = require("react")
ReactDOM = require('react-dom')

Main = require("./flux/views/Main")

$ ->
  app = document.getElementById("app")

  ReactDOM.render(
    `<Main/>`,
    app
  )
