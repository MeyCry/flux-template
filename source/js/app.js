// Generated by CoffeeScript 1.10.0
var $, Main, React, ReactDOM;

$ = require("jquery");

React = require("react");

ReactDOM = require('react-dom');

Main = require("./flux/views/Main");

$(function() {
  var app;
  app = document.getElementById("app");
  return ReactDOM.render(<Main/>, app);
});
