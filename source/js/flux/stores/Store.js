// Generated by CoffeeScript 1.10.0
var CHANGE_EVENT, Constants, Dispatcher, EventEmitter, Store, _, _actions, _containers, _currentLang, _currentVersion, _indexCurrentTab, _indexCurrentVersion, _languages, _textError, _versions, assign, setActions, setContainers, setCurrentLang, setIndexVersion, setLanguages, setVersionList;

Dispatcher = require("../dispatcher/Dispatcher");

EventEmitter = require('events').EventEmitter;

assign = require('object-assign');

Constants = require("../constants");

_ = require("lodash");

CHANGE_EVENT = 'change';

_containers = [];

_actions = [];

_versions = [];

_indexCurrentVersion = null;

_currentVersion = "";

_languages = [];

_indexCurrentTab = 0;

_currentLang = "";

_textError = {
  text: "",
  status: "alert-info"
};

Store = assign({}, EventEmitter.prototype, {
  getContainers: function() {
    return _containers;
  },
  getActions: function() {
    return _actions;
  },
  getLanguages: function() {
    return _languages;
  },
  getIndexCurrentTab: function() {
    return _indexCurrentTab;
  },
  getCurrentLang: function() {
    return _currentLang;
  },
  getVersions: function() {
    return _versions;
  },
  getIndexCurrentVersion: function() {
    return _indexCurrentVersion;
  },
  getCurrentVersion: function() {
    return _currentVersion;
  },
  getTextInfo: function() {
    return _textError;
  },
  emitChange: function() {
    return this.emit(CHANGE_EVENT);
  },
  addChangeListener: function(callback) {
    return this.on(CHANGE_EVENT, callback);
  },
  removeChangeListener: function(callback) {
    return this.removeListener(CHANGE_EVENT, callback);
  }
});

setVersionList = function() {
  return _versions = _.uniq(_containers.map(function(item) {
    return item.version;
  }));
};

setIndexVersion = function(data) {
  _indexCurrentVersion = +data;
  return _currentVersion = _versions[data];
};

setContainers = function(data) {
  return _containers = data;
};

setActions = function(data) {
  return _actions = data;
};

setLanguages = function() {
  return _languages = _.uniq(_containers.map(function(item) {
    return item.locale;
  }));
};

setCurrentLang = function() {
  return _currentLang = _languages[_indexCurrentTab];
};

Store.dispatcherIndex = Dispatcher.register(function(payload) {
  var action, dataCloneAction, dataCloneContainer, defaultClone, index, key, ref, ref1, value;
  dataCloneContainer = _.cloneDeep(_containers);
  dataCloneAction = _.cloneDeep(_actions);
  action = payload.action;
  switch (payload.source) {
    case 'VIEW_ACTION':
      switch (action.actionType) {
        case "changeVersion":
          setIndexVersion(action.data);
          break;
        case "changeActionItem":
          ref = action.data, index = ref.index, key = ref.key, value = ref.value;
          dataCloneAction[index][key] = value;
          setActions(dataCloneAction);
          break;
        case "changeContainerItem":
          ref1 = action.data, index = ref1.index, key = ref1.key, value = ref1.value;
          dataCloneContainer[index][key] = value;
          setContainers(dataCloneContainer);
          break;
        case "addItemAction":
          defaultClone = _.cloneDeep(Constants.DEFAULT_ACTION);
          defaultClone.id = action.data;
          dataCloneAction.push(defaultClone);
          setActions(dataCloneAction);
          break;
        case "addItemContainer":
          dataCloneContainer.push(action.data);
          setContainers(dataCloneContainer);
          break;
        case "deleteItemAction":
          dataCloneAction.splice(action.data, 1);
          setActions(dataCloneAction);
          break;
        case "deleteItemContainer":
          dataCloneContainer.splice(action.data, 1);
          setContainers(dataCloneContainer);
          break;
        case "deleteContainerAction":
          dataCloneContainer[action.data.containerIndex].actions.splice(action.data.actionIndex, 1);
          setContainers(dataCloneContainer);
          break;
        case "addActionToContainer":
          dataCloneContainer[action.data.indexOfContainer].actions.push({
            "container_id": action.data.containerID,
            "action_id": action.data.actionID,
            "position": ""
          });
          setContainers(dataCloneContainer);
          break;
        case "changePositionOfActionInContainer":
          dataCloneContainer[action.data.indexOfContainer].actions[action.data.indexActionInContainer].position = action.data.value;
          setContainers(dataCloneContainer);
          break;
        default:
          return true;
      }
      break;
    case 'SERVER_ACTION':
      action = payload.action;
      switch (action.actionType) {
        case "loadContainers":
          setContainers(action.data);
          setVersionList();
          setLanguages();
          break;
        case "loadActions":
          setActions(action.data);
          break;
        default:
          return true;
      }
      break;
    default:
      return true;
  }
  Store.emitChange();
  return true;
});

module.exports = Store;