--
-- Author: xlook
-- Date: 2017-04-19 11:26:47
--
local BaseScene = require("app.scenes.BaseScene")
local LoginScene = class("LoginScene", BaseScene)
local HttpClient = require("app.net.HttpClient")
local BasicParamModel = require("app.net.BasicParamModel")

function LoginScene:onCreate()
    local scene = cc.CSLoader:createNode("LoginScene/LoginScene.csb")
    local btn_login = scene:getChildByName("Button_1")

    -- local ChildrenList = scene:getChildByName("FileNode_3"):getChildren()
    -- for _,child in pairs(ChildrenList) do
    --     self:generateRealHeight(child,display.height,1334)
    -- end
    self:addChild(scene)

    btn_login:addTouchEventListener(function(sender,event)
        if event == ccui.TouchEventType.ended then
            --[[
		      app 返回 {result = "100",id = "--jpush_registration_id--"}
		    ]]--
		    luaAppBridge({type=Res.lua_action_jpush_rgid},function (event)
		        --authToken调用服务端完成QQ登录
		         -- print("get jpush registerid:",event.result,event.id)
		        dump(event, "event", 6)
		        dump(device, "device", 6)
		        if event.result and event.result == "100" and event.id then
		             -- 网络请求 以及 回调
		            HttpClient.new():onSuccessCallBack(function (dataTable)
		                -- 保存数据
		                dump(dataTable, "HttpClient", 6)
			                -- -- 保存用户信息
			                -- if dataTable.ck and dataTable.uid then
			                --     dataTable.userType = Res.USER_GUEST
			                --     self:saveLoginInfo(dataTable)
			                -- else
			                --     self:loginFailed()
			                --     self:showLoginButtons()
			                -- end

		            end)
		            :onErrorCallBack(function (code,msg)
		                -- 网络请求失败回调函数
		                print("code: "..code.." msg: "..msg)
		                -- self:loginFailed(msg)
		                -- self:showLoginButtons()
		            end)
		            :showLoadingView(self)
		            :doPost(Res.interface.login_guest, BasicParamModel.new({registration_id = event.id}))
		            :start()

		        else
		            local strMsg = event.msg or "jpush rgid 获取失败"
		            showToast(strMsg)
		        end
		    end)
		end
	end)    

end

return LoginScene