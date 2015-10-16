Dispatcher = require("../dispatcher/Dispatcher")
EventEmitter = require('events').EventEmitter
assign = require('object-assign')
Constants = require("../constants")

_ = require("lodash")

CHANGE_EVENT = 'change'

_containers = []
_actions = []

_versions = []
_indexCurrentVersion = null
_currentVersion = ""

_languages = []
_indexCurrentTab = 0
_currentLang = ""

_textError = {
  text: ""
  status: "alert-info" # alert-success, alert-info, alert-danger
}

Store = assign {}, EventEmitter::, {
  getContainers: -> _containers
  getActions: -> _actions

  getLanguages: -> _languages
  getIndexCurrentTab: -> _indexCurrentTab
  getCurrentLang: -> _currentLang

  getVersions: -> _versions
  getIndexCurrentVersion: -> _indexCurrentVersion
  getCurrentVersion: -> _currentVersion

  getTextInfo: -> _textError


  emitChange: -> @emit(CHANGE_EVENT)
  addChangeListener: (callback) -> @on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) -> @removeListener(CHANGE_EVENT, callback)
}

setVersionList = () ->
  _versions = _.uniq(_containers.map((item) -> item.version))

setIndexVersion = (data) ->
  _indexCurrentVersion = +data
  _currentVersion = _versions[data]



setContainers = (data) ->
  _containers = data

setActions = (data) ->
  _actions = data

setLanguages = () ->
  _languages = _.uniq(_containers.map((item) -> item.locale))

setCurrentLang = ->
  _currentLang = _languages[_indexCurrentTab]


Store.dispatcherIndex = Dispatcher.register (payload) ->
  dataCloneContainer = _.cloneDeep(_containers)
  dataCloneAction = _.cloneDeep(_actions)
  action = payload.action


  switch payload.source
    when 'VIEW_ACTION'

      switch action.actionType
        when "changeVersion"
          setIndexVersion(action.data)

        when "changeActionItem"
          {index, key, value} = action.data
          dataCloneAction[index][key] = value
          setActions(dataCloneAction)

        when "changeContainerItem"
          {index, key, value} = action.data
          dataCloneContainer[index][key] = value
          setContainers(dataCloneContainer)

        when "addItemAction"
          defaultClone = _.cloneDeep(Constants.DEFAULT_ACTION)
          defaultClone.id = action.data
          dataCloneAction.push(defaultClone)
          setActions(dataCloneAction)

        when "addItemContainer"
          dataCloneContainer.push(action.data)
          setContainers(dataCloneContainer)

        when "deleteItemAction"
          # action.data is index
          dataCloneAction.splice(action.data, 1)

          setActions(dataCloneAction)

        when "deleteItemContainer"
          dataCloneContainer.splice(action.data, 1)

          setContainers(dataCloneContainer)

        when "deleteContainerAction"
          dataCloneContainer[action.data.containerIndex].actions.splice(action.data.actionIndex, 1)
          setContainers(dataCloneContainer)

        when "addActionToContainer"
          dataCloneContainer[action.data.indexOfContainer].actions.push({
            "container_id": action.data.containerID
            "action_id": action.data.actionID
            "position": "" # by default is empty from server is int
          })
          setContainers(dataCloneContainer)

        when "changePositionOfActionInContainer"
          dataCloneContainer[action.data.indexOfContainer]
            .actions[action.data.indexActionInContainer]
            .position = action.data.value

          setContainers(dataCloneContainer)

        else return true


    when 'SERVER_ACTION'
      action = payload.action

      switch action.actionType
        when "loadContainers"
          setContainers(action.data)
          setVersionList()
          setLanguages()

        when "loadActions"
          setActions(action.data)

#        when "submitItemContainer"

#        when "submitItemAction"

        else return true

    else return true

  Store.emitChange()
  return true;

module.exports = Store
