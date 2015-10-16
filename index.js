var express = require('express');
var app = express();
var jsx = require('node-jsx');
jsx.install();
var React = require("react");
var ReactDOM = require('react-dom/server');
var ReactApp = require("./source/js/appServer");

var reactHtml = React.createFactory(ReactApp.Main);


app.set('view engine', 'ejs');

app.use(express.static('public'));

app.get('/', function (req, res) {
  console.log(reactHtml);

  res.render("index", {reactOutput: ReactDOM.renderToString(reactHtml())})
});

var server = app.listen(3000, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port)

});