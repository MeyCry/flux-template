Dispatcher = require("../dispatcher/Dispatcher")
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
#Constants = require("../constants")

_ = require("lodash")

CHANGE_EVENT = 'change'

_countClick = 0

Store = assign {}, EventEmitter::, {
  getCountClick: -> _countClick


  emitChange: -> @emit(CHANGE_EVENT)
  addChangeListener: (callback) -> @on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) -> @removeListener(CHANGE_EVENT, callback)
}

setCountClick = (value) -> _countClick = value


Store.dispatcherIndex = Dispatcher.register (payload) ->
  action = payload.action
  switch payload.source
    when 'VIEW_ACTION'

      value = action.data
      switch action.actionType
        when "clickOnBtn"
          setCountClick(value)

        else return true


    when 'SERVER_ACTION'
      action = payload.action

      switch action.actionType
        when "loadContainers"
          console.log "hi"

        else return true

    else return true

  Store.emitChange()
  return true;

module.exports = Store
