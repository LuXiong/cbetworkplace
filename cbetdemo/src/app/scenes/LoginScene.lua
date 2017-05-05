--
-- Author: xlook
-- Date: 2017-04-19 11:26:47
--
local LoginScene = class("LoginScene", BaseScene)

local listener_guest_login = function(sender,event)
    if event == ccui.TouchEventType.ended then
        -- app 返回 {result = "100",id = "--jpush_registration_id--"}
	    luaAppBridge({type=Res.lua_action_jpush_rgid},function (event)
	        if event.result and event.result == "100" and event.id then
	            HttpClient.new():onSuccessCallBack(function (dataTable)
	                -- 保存用户信息
	                if dataTable.ck and dataTable.uid then
	                    dataTable.userType = Res.USER_GUEST
	                    this:saveLoginInfo(dataTable)
	                else
	                    this:loginFailed()
	                    this:showLoginButtons()
	                end
	            end)
	            :onErrorCallBack(function (code,msg)
	                print("code: "..code.." msg: "..msg)
	            end)
	            -- :showLoadingView(self)
	            :doPost(Res.interface.login_guest, BasicParamModel.new({registration_id = event.id}))
	            :start()

	        else
	            local strMsg = event.msg or "jpush rgid 获取失败"
	            showToast(strMsg)
	        end
	    end)
	end
end

function LoginScene:onCreate()
	LoginScene.super.onCreate(self)
	self:bindView()
	self:bindEvents()
	local msg = cc.Test:helloMsg()
 	print("luaclibtest:"..msg)
	-- print("luaclibtest:"..mylib.mysin(3.14 / 2)) 
end

function LoginScene:bindView()
	local scene = cc.CSLoader:createNode("LoginScene/LoginScene.csb")
    self.btn_login = scene:getChildByName("btn_guest")
    self:addChild(scene)
end

function LoginScene:bindEvents()
	-- self.btn_login:addTouchEventListener(listener_guest_login)
end

-- 登录成功了，保存登录信息。并获取用户信息
function LoginScene:saveLoginInfo(loginInfo)
    -- 保存用户信息
    if loginInfo.ck and loginInfo.uid and loginInfo.userType then
        local dm_userInfo = {
            ck = loginInfo.ck,
            username = "",
            uid = loginInfo.uid,
            gold = "0",
            diamond = "0",
            loginTime = os.time()
        }
        --保存用户类型
        gameData.loginType = loginInfo.userType
        gameData.userInfo = dm_userInfo
        GameState.save(gameData)
        -- 获取账户信息
        Cbet_UserInfo:getInstance():getUserInfo(self)
        -- 极光推送
        -- luaAppBridge({type=Res.lua_action_jpush_alias,uid = loginInfo.uid},function (event)
        --      -- print("set jpush alias:",event.result)
        -- end)
        -- luaAppBridge({type=Res.lua_action_jpush_tags},function (event)
        --      -- print("set jpush tags:",event.result)
        -- end)
    else
        self:showLoginButtons()
    end
end

return LoginScene