Dispatcher = require("../dispatcher/Dispatcher")
EventEmitter = require('events').EventEmitter
assign = require('object-assign')

Store = require("./Store")

CHANGE_EVENT_NOTIFY = "changeNotify"

_notify = {
  text: ""
  status: "alert-info" # alert-success, alert-info, alert-danger
}

NotifyStore = assign {}, EventEmitter::, {
  getNotify: -> _notify


  emitChange: -> @emit(CHANGE_EVENT_NOTIFY)
  onNotify: (callback) -> @on(CHANGE_EVENT_NOTIFY, callback)
  offNotify: (callback) -> @removeListener(CHANGE_EVENT_NOTIFY, callback)
}

setNotify = (data) -> _notify = data

NotifyStore.dispatcherIndex = Dispatcher.register (payload) ->

  action = payload.action

  switch action.actionType
    when "notify"
      setNotify(action.data)

  NotifyStore.emitChange()

  setTimeout ->
    setNotify({
      text: ""
      status: "" # alert-success, alert-info, alert-danger
    })
    NotifyStore.emitChange()

  , 6000

  return true;

module.exports = NotifyStore
