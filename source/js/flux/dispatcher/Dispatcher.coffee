Dispatcher = require("flux").Dispatcher

Dispatcher::handleViewAction = (action) ->
  @dispatch({
    source: 'VIEW_ACTION',
    action: action
  })

Dispatcher::handleServerAction = (action) ->
  @dispatch({
    source: 'SERVER_ACTION'
    action: action
  })

module.exports = new Dispatcher()