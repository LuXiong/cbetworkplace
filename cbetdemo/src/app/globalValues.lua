--
-- Author: xlook
-- Date: 2017-04-20 11:03:20
--
require("app.contacts.Res")

-- cc.exports.GameState = import("framework.cc.utils.GameState")
cc.exports.gameData = {version = "1.1.2",needVerifyCode = false, loginType = "0",userInfo={},userConfing={},imgCache={},SOUND_EFFECT=true,SOUND_LIVE_EFFECT=true}
cc.exports.luaoc = require("app.quickframe.luaoc")

-- cc.exports.crypto = require("app.quickframe.crypto")
-- cc.exports.GameState = require("app.quickframe.GameState")
cc.exports.scheduler = require("app.quickframe.scheduler")

cc.exports.HttpClient = require("app.net.HttpClient")
cc.exports.BasicParamModel = require("app.net.BasicParamModel")

cc.exports.BaseScene = require("app.scenes.BaseScene")

cc.exports.gameData = {}
cc.exports.this = {}

-- cc.exports.mylib = require "app.libs.mylib"