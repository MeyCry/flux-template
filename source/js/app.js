// Generated by CoffeeScript 1.10.0
var $, Category, Main, React, ReactDOM, ReactRouter, Route, Router;

$ = require("jquery");

React = require("react");

ReactDOM = require('react-dom');

Main = require("./flux/views/Main");

Category = require("./flux/views/Category");

ReactRouter = require('react-router');

Router = ReactRouter.Router, Route = ReactRouter.Route;

$(function() {
  return ReactDOM.render((
      <Router>
        <Route path="/" component={Main}></Route>
        <Route path="category" component={Category}/>
      </Router>
    ), document.getElementById("app"));
});
