--
-- Author: xlook
-- Date: 2017-04-20 14:20:52
--
local BaseScene = class("BaseScene", cc.load("mvc").ViewBase)

local HttpClient = require("app.net.HttpClient")
local BasicParamModel = require("app.net.BasicParamModel")

function BaseScene:onCreate()
	BaseScene.f_pageOpenTime = checknumber(socket.gettime())
	-- str_willEnterSceneName = display.getRunningScene().__cname
	print("BaseScene----->onCreate()")
	this = self
	local function onNodeEvent(event)
		if event == "enter" then
			--场景进入时触发
			self:onEnter()
		elseif event == "enterTransitionFinish" then
			--当前场景进入并完成过渡动画时触发
			self:onEnterTransitionFinish()
		elseif event == "exitTransitionStart" then
			--场景退出时过渡动画开始时触发
			self:onExitTransitionStart()
		elseif event == "exit" then
			--场景退出时触发
			self:onExit()
		elseif event == "cleanup" then
			--场景销毁时触发
			self:onCleanup()
		end
	end
	self:registerScriptHandler(onNodeEvent)
	--android平台增加返回键处理
	if device.platform == "android" then
		self:addKeyBackExitEvent()
	end
end

-- function BaseScene:addKeyBackExitEvent()
-- 	self:setKeypadEnabled(true)
-- 	self:addNodeEventListener(cc.KEYPAD_EVENT, function (event)
--     	if event.key == "back" then
-- 			self:onBack()
--     	end
-- 	end)
-- end

-- function BaseScene:getToken( func )
-- 	if func then
-- 		self.callb_func = func
-- 	end
--     HttpClient.new():onSuccessCallBack(function (dataTable)
--         DataTokenInstance:getInstance():onSucess(dataTable)
--         if self.callb_func then
--         	self.callb_func()
--         end
--     end)
--     :doPost(Res.interface.tokeninfo, BasicParamModel.new({}))
--     :showLoadingView(self)
--     :start()
-- end

--[[
	场景进入时触发
]]--
function BaseScene:onEnter()
	-- print("used time: "..socket.gettime().."ms")
	-- print("BaseScene----->onEnter")
end

--[[
	前场景进入并完成过渡动画时触发
]]--
function BaseScene:onEnterTransitionFinish()
	-- if self.f_pageOpenTime then
	-- 	StaticToolUtil.onEvent(Res.TDEVENT_PAGEOPEN,{[str_willEnterSceneName] = (checknumber(socket.gettime()) - BaseScene.f_pageOpenTime)*1000})
	-- end
	
	-- print("used time: "..socket.gettime().."ms")
	-- print("BaseScene----->onEnterTransitionFinish")
end

--[[
	场景退出时过渡动画开始时触发
]]--
function BaseScene:onExitTransitionStart()
	-- print("used time: "..socket.gettime().."ms")
	-- print("BaseScene----->exitTransitionStart")
end

function BaseScene:onExit()
	-- print("used time: "..socket.gettime().."ms")
	-- print("BaseScene----->onExit")
end

--[[
	场景销毁时触发
]]--
function BaseScene:onCleanup()
	-- print("BaseScene----->cleanup")
end

function BaseScene:onBack()
	-- app:enterScene(nil, nil, "crossFade", 0.3,{isBack = true}, nil)
	-- MusicConfig.playSound(Res.sound_click_return)
end

-- --[[
--   处理是否需要返回按键
-- ]]--
-- function BaseScene:handlerKeyBackEvent(bool_enable)
-- 	if device.platform == "android" then
-- 		self:setKeypadEnabled(bool_enable)
-- 	end
-- end

-- --[[
--   用作jp 游戏内部跳转通用方法
-- ]]--
-- function BaseScene:jumpAction(params)
-- 	print("basescene jumpAction")
-- 	dump(params)
-- end

return BaseScene