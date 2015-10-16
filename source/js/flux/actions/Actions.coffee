Dispatcher = require('../dispatcher/Dispatcher')
Constants = require("../constants")

_ = require("lodash")

Actions = {
  clearNotify: ->
    Dispatcher.handleViewAction({
      actionType: "notify"
      data: {
        text: ""
        status: ""
      }
    })

  submitItemContainer: (index, containerData) ->
    Dispatcher.handleServerAction({
      actionType: "submitItemContainer"
      data: index
    })

    $.ajax({
      url: "/admin/api/containers"
      type: "PATCH"
      dataType: 'json'
      contentType: "application/json"
      data: JSON.stringify containerData
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Submit Container: server not eat this"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Submit Container is done"
          status: "alert-success"
        }
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: w
          status: "alert-danger"
        }
      })


  submitItemAction: (index, actionData) ->
    Dispatcher.handleServerAction({
      actionType: "submitItemAction"
      data: index
    })

    $.ajax({
      url: "/admin/api/actions"
      type: "PATCH"
      dataType: 'json'
      contentType: "application/json"
      data: JSON.stringify actionData
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Submit Action: server not eat this"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Submit Action is done"
          status: "alert-success"
        }
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: w
          status: "alert-danger"
        }
      })

  loadData: () ->
    Dispatcher.handleServerAction({
      actionType: "notify"
      data: {
        text: "Loading..."
        status: "alert-info"
      }
    })

    $.ajax({
      url: "/admin/api/containers"
      type: "GET"
      dataType: "JSON"
    }).done (data) ->
      if data.status? and data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Server can not reed data from Containers"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "loadContainers"
        data: data
      })
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Data is ready"
          status: "alert-success"
        }
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: w
          status: "alert-danger"
        }
      })

    $.ajax({
      url: "/admin/api/actions"
      type: "GET"
      dataType: "JSON"
    }).done (data) ->
      if data.status? and data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Server can not reed data from Actions"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "loadActions"
        data: data
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: w
          status: "alert-danger"
        }
      })

  addActionToContainer: (actionID, containerID, indexOfContainer) ->
    Dispatcher.handleViewAction({
      actionType: "addActionToContainer"
      data: {
        actionID: actionID
        containerID: containerID
        indexOfContainer: indexOfContainer
      }
    })

  addLanguage: (data) ->
    Dispatcher.handleViewAction({
      actionType: "addLanguage"
      data: data
    })

  addItemAction: () ->
    # add action
    $.ajax({
      url: "/admin/api/actions"
      type: "POST"
      dataType: 'json'
      contentType: "application/json"
      data: JSON.stringify Constants.DEFAULT_ACTION
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Add Action fail: server not eat this"
            status: "alert-warning"
          }
        })

      Dispatcher.handleViewAction({
        actionType: "addItemAction"
        data: data.status # id of action
      })
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Add Action success"
          status: "alert-success"
        }
      })

    .error (q,w,e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Add Action fail " + w
          status: "alert-danger"
        }
      })


  addItemContainer: (countOfContainers) ->
    cloneContainer = _.cloneDeep(Constants.DEFAULT_CONTAINER)
    cloneContainer.priority = countOfContainers

    # add container
    $.ajax({
      url: "/admin/api/containers"
      type: "POST"
      dataType: 'json'
      contentType: "application/json"
      data: JSON.stringify cloneContainer
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Add Container fail: server not eat this"
            status: "alert-warning"
          }
        })

      cloneContainer.id = data.status # id of container

      Dispatcher.handleViewAction({
        actionType: "addItemContainer"
        data: cloneContainer # new container and id
      })

      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Add Container success"
          status: "alert-success"
        }
      })

    .error (q,w,e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Add Container fail " + w
          status: "alert-danger"
        }
      })

  deleteItemAction: (index, itemAction) ->
    Dispatcher.handleViewAction({
      actionType: "deleteItemAction"
      data: index
    })

    # ajax delete
    data = JSON.stringify(itemAction)
    $.ajax({
      url: "/admin/api/actions"
      type: "DELETE"
      dataType: 'json'
      contentType: "application/json"
      data: data
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Delete Action: server not eat this"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Delete Action success"
          status: "alert-success"
        }
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Delete Action fail " + w
          status: "alert-danger"
        }
      })

  deleteItemContainer: (index, itemContainer) ->
    Dispatcher.handleViewAction({
      actionType: "deleteItemContainer"
      data: index
    })

    # ajax delete
    data = JSON.stringify(itemContainer)
    $.ajax({
      url: "/admin/api/containers"
      type: "DELETE"
      dataType: 'json'
      contentType: "application/json"
      data: data
    }).done (data) ->
      if data.status is false
        return Dispatcher.handleServerAction({
          actionType: "notify"
          data: {
            text: "Delete Container: server not eat this"
            status: "alert-warning"
          }
        })

      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Delete Container success"
          status: "alert-success"
        }
      })

    .error (q, w, e) ->
      Dispatcher.handleServerAction({
        actionType: "notify"
        data: {
          text: "Delete Container fail " + w
          status: "alert-danger"
        }
      })

  deleteContainerAction: (containerIndex, actionIndex) ->
    Dispatcher.handleViewAction({
      actionType: "deleteContainerAction"
      data: {
        containerIndex: containerIndex
        actionIndex: actionIndex
      }
    })

  changeActionItem: (index, key, value) ->
    Dispatcher.handleViewAction({
      actionType: "changeActionItem",
      data: {
        index: index
        key: key
        value: value
      }
    })

  changeContainerItem: (index, key, value) ->
    Dispatcher.handleViewAction({
      actionType: "changeContainerItem",
      data: {
        index: index
        key: key
        value: value
      }
    })

  changeVersion: (index) ->
    Dispatcher.handleViewAction({
      actionType: "changeVersion"
      data: index
    })

  changePositionOfActionInContainer: (indexActionInContainer, indexOfContainer, value) ->
    Dispatcher.handleViewAction({
      actionType: "changePositionOfActionInContainer"
      data: {
        indexActionInContainer: indexActionInContainer,
        indexOfContainer: indexOfContainer
        value: value
      }
    })
}

module.exports = Actions