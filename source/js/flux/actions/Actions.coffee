Dispatcher = require('../dispatcher/Dispatcher')
#Constants = require("../constants")

_ = require("lodash")

Actions = {


  clickOnBtn: (value) ->
    Dispatcher.handleViewAction({
      actionType: "clickOnBtn"
      data: value
    })
}

module.exports = Actions