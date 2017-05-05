
Cbet_UserInfo = {}


function Cbet_UserInfo:new(o)
	u = u or {}
	setmetatable(u,self)
	self.__index = self
	return u
end

-- 获取单例
-- 2016-8-23 LeoHao
function Cbet_UserInfo:getInstance()
	if self.instance == nil then
		self.instance = self:new()
	end
	return self.instance
end

-- 计时器 初始化
-- 2016-8-23 by LeoHao
function Cbet_UserInfo:initScheduler()
	if self.time_scheduler then
		return
	end
	self.i_time = 0
	self.time_scheduler = scheduler.scheduleGlobal(function()
		 if self.i_time >= 30 then
            self:getSimpleUserInfo()
            self:getUserActivityInfo()
		 	self.i_time = 0
		 end
		 self.i_time = self.i_time + 1
	end,1)
end

-- 计时器 销毁
-- 2016-8-23 by LeoHao
function Cbet_UserInfo:stopTimeScheduler(  )
	if self.time_scheduler then
		scheduler.unscheduleGlobal(self.time_scheduler)
		self.time_scheduler = nil
	end
end

-- 获取简单账户信息
function Cbet_UserInfo:getSimpleUserInfo(  )
    -- 退出登录后，ck设置为空字符串，此时不应该再刷新账户信息了
    if (not gameData.userInfo) or #gameData.userInfo.ck == 0 then
        return
    end

    HttpClient.new():onSuccessCallBack(function (dataTable)
        -- dump(dataTable, "simple_user_info", 6)
        -- 保存数据
        local tb_userInfo = gameData.userInfo
        table.merge(tb_userInfo,dataTable)
        gameData.userInfo = tb_userInfo
        GameState.save(gameData)
        local currentScene = display.getRunningScene()
        if currentScene.refreshUserInfo then
            currentScene:refreshUserInfo()
        end
        dump(gameData.userInfo, "userinfo", 6)
    end)
    :onErrorCallBack(function (code,msg)
        local currentScene = display.getRunningScene()
        if currentScene.getUserInfoFailed then
            currentScene:getUserInfoFailed(code,msg)
        end
    end)
    -- :showLoadingView(scene)
    :doPost(Res.interface.simple_userinfo, BasicParamModel.new({}))
    :start()
end


-- 获取简单账户信息
function Cbet_UserInfo:getUserActivityInfo( )
    -- 退出登录后，ck设置为空字符串，此时不应该再刷新账户信息了
    if (not gameData.userInfo) or #gameData.userInfo.ck == 0 then
        return
    end

    HttpClient.new():onSuccessCallBack(function (dataTable)
        -- dump(dataTable, "simple_activity_info", 6)
        -- 保存数据
        local tb_userInfo = gameData.userInfo
        table.merge(tb_userInfo,dataTable)
        gameData.userInfo = tb_userInfo
        GameState.save(gameData)
        local currentScene = display.getRunningScene()
        if currentScene.refreshUserInfo then
            currentScene:refreshUserInfo()
        end
        dump(gameData.userInfo, "userinfo", 6)
    end)
    :onErrorCallBack(function (code,msg)
        local currentScene = display.getRunningScene()
        if currentScene.getUserInfoFailed then
            currentScene:getUserInfoFailed(code,msg)
        end
    end)
    -- :showLoadingView(scene)
    :doPost(Res.interface.activity_info, BasicParamModel.new({}))
    :start()
end

-- 从服务器刷新账户信息
-- 2016-8-23 by LeoHao
function Cbet_UserInfo:getUserInfo(scene)
    -- 退出登录后，ck设置为空字符串，此时不应该再刷新账户信息了
    self:clearDots()
    if not gameData.userInfo or string.len(gameData.userInfo.ck) == 0 then
        return
    end

	HttpClient.new():onSuccessCallBack(function (dataTable)
        -- dump(dataTable)
        -- 保存数据
        local tb_userInfo = gameData.userInfo
        table.merge(tb_userInfo,dataTable)
        -- 屏蔽开关，是否可以分享，以及是否可以展示苹果审核不允许的内容
        bl_shareEnable = (checknumber(tb_userInfo.mask_switcher) == 1)
        -- 测试代码，打包前要注释
        -- bl_shareEnable = false

        gameData.userInfo = tb_userInfo
        GameState.save(gameData)

        --添加talkingdata数据统计
        local tkType = StaticToolUtil.getUserType(gameData.loginType)
        StaticToolUtil.updateUserAccount(tb_userInfo.uid,tb_userInfo.username,tkType)

        local currentScene = display.getRunningScene()
        if currentScene.refreshUserInfo then
        	currentScene:refreshUserInfo()
        end
    end)
    :onErrorCallBack(function (code,msg)
	    local currentScene = display.getRunningScene()
	    if currentScene.getUserInfoFailed then
        	currentScene:getUserInfoFailed(code,msg)
        end
    end)
    :showLoadingView(scene)
    :doPost(Res.interface.longin_userinfo, BasicParamModel.new({}))
    :start()
end

-- 从服务器刷新账户信息
-- 2016-8-23 by LeoHao
function Cbet_UserInfo:getChampionshipUserInfo(scene,championshipId)
    -- 退出登录后，ck设置为空字符串，此时不应该再刷新账户信息了
    if not gameData.userInfo or string.len(gameData.userInfo.ck) == 0 then
        return
    end

    HttpClient.new():onSuccessCallBack(function (dataTable)
        -- dump(dataTable)
        -- 保存数据
        if dataTable then
           dataTable.cgold = dataTable.account
        else
            dataTable = {}
        end
        local currentScene = display.getRunningScene()
        if currentScene.refreshChampionshipUserInfo then
            currentScene:refreshChampionshipUserInfo(dataTable)
        end
    end)
    :onErrorCallBack(function (code,msg)
        local currentScene = display.getRunningScene()
        if currentScene.getUserInfoFailed then
            currentScene:getUserInfoFailed(code,msg)
        end
    end)
    :showLoadingView(scene)
    :doPost(Res.interface.championship_match_user_info, BasicParamModel.new({championid = championshipId}))
    :start()
end

function Cbet_UserInfo:clearDots( )
    if device.platform == "ios" then
        luaAppBridge({type=Res.lua_action_clear_badge},function (event)
        end)
    end
end

function Cbet_UserInfo:logout(state,errorMessage)
    gameData.userInfo.ck = ""
    GameState.save(gameData)
    app:enterScene("MainScene",{params = {{code = state,message = errorMessage}}}, "crossFade", 0.5,{clear = true})
    stopSchedule()
end

return Cbet_UserInfo

