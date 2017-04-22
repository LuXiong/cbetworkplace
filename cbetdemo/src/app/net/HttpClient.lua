--
-- Author: meixx
-- Date: 2016-07-20 17:18:09
-- changed by xlool 2016-04-19
--[[
 网络请求类
]]
-- local LoadingView = require("app.scenes.view.LoadingAnimationView")

local socket = require("socket.core")
local HttpClient = class("HtpClient")
local BasicParamModel = require("app.net.BasicParamModel")
-- local GameState = import("framework.cc.utils.GameState")


--[[
	table option 参数
	      showloadingview  是否显示加载动画
]]
function HttpClient:ctor()
	
end

--[[
  Post请求 默认加密
  eg:  
    HttpClient.new():onPreExecuteCallBack(function ()
        -- body
    end):onSuccessCallBack(function (data)
        -- body
    end):onErrorCallBack(function (code,msg)
        -- body
    end):doPost("http://192.168.41.76:8899/match/football/list", nil):start()
	--加密
	HttpClient.new():doPost()
	--不加密
	HttpClient.new():doPostWithEntry()
]]--
function HttpClient:doPost(url,childParamModel)
	self.str_urlInterface = url
		if Res.http_status_config == "on" then
		self.str_urlInterface = string.gsub(self.str_urlInterface, "https://crazybet.choopaoo.com:47899", "http://crazyproxy.choopaoo.com:7899");
		self.str_urlInterface = string.gsub(self.str_urlInterface, "https://crazybet.choopaoo.com:47799", "http://crazyproxy.choopaoo.com:7799");
		print("url = ",self.str_urlInterface)
	end

	self.f_postTime = checknumber(socket.gettime())
	--暂时 加密
	local needEntryData = false
	if self.str_urlInterface == Res.interface.tokeninfo then
		needEntryData = false
	end
	self:doPostWithEntry(self.str_urlInterface,childParamModel,needEntryData)
	return self
end

--[[
  Post请求 可配置是否加密
]]--
function HttpClient:doPostWithEntry(url,childParamModel,needEntryData)
	self.url = url
	self.childParamModel = childParamModel
	self.needEntryData = needEntryData
	return self
end


--[[
	开始请求
]]
function HttpClient:start()
	local bl_tokenValid = DataTokenInstance:getInstance():isTokenValid()
    if not bl_tokenValid and self.str_urlInterface ~= Res.interface.tokeninfo and self.str_urlInterface ~= Res.interface.app_update then
    	-- print("not bl_tokenValid ===========")
    	self:getToken(function (  )
        	self:start()
        end)
        return
    end
    print("self.str_urlInterface:",self.str_urlInterface)
	--网络请求地址不能为空 
	assert(type(self.url)=="string" and #self.url>4,".......error!!.......网络请求url无效!"..self.url)
	-- dump(self.childParamModel)
	if not self.childParamModel then
		self.childParamModel = BasicParamModel.new()
	end

	if self.needEntryData then
		--检查Token 有效性，无效重新获取
		DataTokenInstance:getInstance():checkTokenState()
		-- dump(DataTokenInstance:getInstance())
	end

	-- print("请求url:  "..self.url)
	-- local result = ""
	local responseData =""

	--BEGIN 网络请求响应函数 
	local function onRequestFinished(event)
			--屏蔽请求进度信息
			-- if event.name=="progress" then
			-- 	return
			-- end

			--隐藏加载动画
			-- self:hideLoadingAnimation()

			-- -- print("net work event name :"..event.name)
			-- local status = (event.name=="completed")
			-- local request = event.request
			-- if not status then
			-- 	-- print(request:getErrorCode(),request:getErrorMessage())
			-- 	self:netErrorHandler(request:getErrorCode(),request:getErrorMessage())
			-- 	return
			-- end
			local code = self.netRequest.status
			-- print("response code :"..code)
			
            print("xmlhttprequest.readyState is:", self.netRequest.readyState, "xmlhttprequest.status is: ",code)
   

			--网络请求成功
			if code==200 then
				-- StaticToolUtil.onEvent(Res.TDEVENT_NETWORK,{[self.str_urlInterface] = (checknumber(socket.gettime()) - self.f_postTime)*1000})
				--获取网络响应头信息
	  			-- local respHeadStr = self.netRequest:getResponseHeadersString()
	  			print("respHeadStr:",self.netRequest:getResponseHeader("Content-Type"))
	  			--获取网络响应内容
				responseData = self.netRequest.response
				-- result = "result code:200".." data:"..responseData
				-- print("responseData = ",responseData,"------------------------")

				--根据响应头文件信息 判断是否需要解密
				-- local strStart,strEnd = string.find(string.lower(respHeadStr),"application/ews")
	  	-- 		if strStart then
	  	-- 			--需要解密
	  	-- 			-- print("返回数据已加密","接口url: "..self.url)
	  	-- 			local table_data = RC4(DataTokenInstance:getInstance():getPrivateKey(), responseData)
	  	-- 			if table_data then
	  	-- 				responseData = table_data
	  	-- 			end
	  	-- 		else
	  	-- 			-- print("返回数据未加密","接口url: "..self.url)
	  	-- 		end
	  			
	  			responseData = json.decode(responseData)
	  			
				dump(responseData,"xmlhttpclient responseData",6)

				 --数据返回成功 判断服务端业务逻辑状态 100为正常状态
				 if responseData and responseData.status == "100" then
				 	--正常业务状态码
				 	if self.callb_onSuccess then
				 		--接口数据 业务逻辑正常
						self.callb_onSuccess(responseData.data)
					end
				elseif responseData and (responseData.status == "102" or responseData.status == "136") then
					-- ck失效 102    -----136 ck失效（被其他设备挤出）
					-- UserInfo:getInstance():logout(responseData.status,responseData.message)
				elseif not responseData then
					--错误业务逻辑状态码
					self:netErrorHandler("0","数据异常")
				 else	
				 	--错误业务逻辑状态码
					self:netErrorHandler(responseData.status,responseData.message)
				 end

			else 
			    --网络通讯异常状态码  非200 回调	
				self:netErrorHandler(code,self.netRequest.response)
			end
			self.netRequest:unregisterScriptHandler()
	end
	--END 网络请求响应函数 


	--网络请求执行前
	if self.callb_onPreExecute then
		self.callb_onPreExecute()
	end

	--是否展示加载动画
	if self.currentScene then
		-- print("展示加载动画")
		-- self:showLoadingAnimation()
	else
		-- print("不展示加载动画")
	end

	--如果需要加密 需处理请求连接
	if self.needEntryData then
		self.url = self.url.."?data_type="..DataTokenInstance:getInstance():getType().."&data_key="..DataTokenInstance:getInstance():getKey();
	end

	--初始化网络请求
	-- self.netRequest  = network.createHTTPRequest(onRequestFinished, self.url, "Post")

	self.netRequest = cc.XMLHttpRequest:new()
    -- self.netRequest.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    self.netRequest:open("POST", self.url)

	--整合网络请求参数
	local allRequestParams = self.childParamModel:getRequestParams()

	--打印网络请求参数
	print(self.url)
	dump(allRequestParams)

	---加密数据
	local entryData

	if self.needEntryData then
		-- print("加密方式",DataTokenInstance:getInstance():getType())
		--需要加密处理 增加请求头配置
		self.netRequest:setRequestHeader("Content-Type","application/ews_"..DataTokenInstance:getInstance():getType())
		assert(string.len(DataTokenInstance:getInstance():getPrivateKey())>0,"无效的 PrivateKey")
		-- print("PrivateKey",DataTokenInstance:getInstance():getPrivateKey())

		--加密数据
		entryData = RC4(DataTokenInstance:getInstance():getPrivateKey(), json.encode(allRequestParams))
		-- print("secret = ",DataTokenInstance:getInstance().secret,"----------------")
		
		-- local buffer = RC4(DataTokenInstance:getInstance():getPrivateKey(), entryData)
		-- print("RC4 对接口参数解密为：",buffer,"--------------------")
	else
		--无加密处理
		--android 平台请求头 使用 = 连接
		self.netRequest:setRequestHeader("Content-Type","application/json")
		entryData = json.encode(allRequestParams)
	end

	--  
	dump(entryData, "entryData", 6)
	-- self.netRequest:setHttpRequestData(entryData)
	self.netRequest:registerScriptHandler(onRequestFinished)
    self.netRequest:send(entryData)

end

--[[
	设置是否显示loading view 
]]
function HttpClient:showLoadingView(scene)
	if scene then
		--显示动画的场景
		self.currentScene = scene
	else
		self.currentScene = nil
	end
	return self
end


--[[
	添加展示加载loading动画
]]
-- function HttpClient:showLoadingAnimation()
-- 	if self.currentScene then
-- 		self.loadingView = LoadingView.new()
--     	self.currentScene:addChild(self.loadingView, 1000)
-- 	end
-- end


--[[
	移除加载loading动画
]]
-- function HttpClient:hideLoadingAnimation()
-- 	if self.loadingView and self.loadingView.removeView then
-- 		self.loadingView:removeView()
-- 	end
-- end


--[[
  文件下载
]]
function HttpClient:downloadFile(url,filename)
	self.url = url
	self.fileName = filename
	return self
end

function HttpClient:startDownLoad()
	--网络请求地址不能为空 
	assert(type(self.url)=="string" and #self.url>4,".......error!!.......网络请求url无效!")
	-- dump(childParamModel)
	-- print("请求url:  "..self.url)

	--文件下载路径
	local fileAbsolutePath = self.fileName

	--BEGINE 网络请求响应函数
	local function onRequestFinished(event)
			-- local tb_data = json.decode(responseData)
			--请求进度信息
			if event.name=="progress" then
				-- print("progress :",event.name,event.dltotal)
				return
			end

			-- print("net work event name :"..event.name)

			local status = (event.name=="completed")
			local request = event.request

			if not status then
				-- print(request:getErrorCode(),request:getErrorMessage())
				self:netErrorHandler(request:getErrorCode(),request:getErrorMessage())
				return
			end

			--网络响应状态码
			local code = request:getResponseStatusCode()
			-- print("response code :"..code)

			if code==200 then
				--根据文件下载链接截取文件名称

				assert(type(fileAbsolutePath)=="string" and string.len(fileAbsolutePath) >0,"Error !!!无效的文件名称！！！")
				local i_dataLength = request:getResponseDataLength()
				-- print("文件大小:",i_dataLength)
				-- print("文件路径:",fileAbsolutePath)
				--保存文件
				request:saveResponseData(fileAbsolutePath)

				if self.callb_onSuccess then
					self.callb_onSuccess(fileAbsolutePath,i_dataLength)
				end

			else 
				--网络状态码 非 200 状态
				self:netErrorHandler(request:getErrorCode(),request:getErrorMessage())
			end
	end
	--END 网络请求响应函数

	--网络请求执行前
	if self.callb_onPreExecute then
		self.callb_onPreExecute()
	end
	--初始化网络请求
	local netRequest  = network.createHTTPRequest(onRequestFinished, self.url, "get")

	-- --获取网络请求参数
	-- local allRequestParams = childParamModel:getRequestParams()
	-- -- 
	-- --打印网络请求参数
	-- dump(allRequestParams)

	netRequest:start()
end

--[[
	设置网络加载前回调函数
]]--
function HttpClient:onPreExecuteCallBack(func_onPreExecute)
	self.callb_onPreExecute = func_onPreExecute
	return self
end

--[[
	设置网络加载成功回调函数
]]--
function HttpClient:onSuccessCallBack(func_onSuccess)
	self.callb_onSuccess = func_onSuccess
	return self
end

--[[
	设置网络加载失败回调函数
]]--
function HttpClient:onErrorCallBack(func_onError)
	self.callb_onError = func_onError
	return self
end

--[[
 网络提示默认处理
]]--
function HttpClient:netErrorHandler(code,msg)
	-- print("net error!!!!!!!!!!!!",code,msg)

	if self.callb_onError then
		--返回是否需要httpclient内部处理
		if code == 0 or code == 28 or code == 7 or code == 6  then
			--网络无连接
			msg = "哎呀，网络丢失啦，请稍后重试"
		end
		if code == 500 then
			--服务器错误
			msg = "服务异常,火速修复中"
		end
		if code == 52 then
			msg = "获取数据失败了，请检查网络再试试吧"
		end
		local state = self.callb_onError(code,msg)
		if state then
			self:errorDefaultHandler(code,msg)
		end
	else
		self:errorDefaultHandler(code,msg)
	end
end

function HttpClient:errorDefaultHandler(code,msg)
	-- print("code = "..code.."messge = "..msg)
	--默认处理
	local showMsg = ""
	--[[
    0   无网络
    28  timeout
     7  cannot connect to server
	]]--
	if code == 0 or code == 7 or code == 6 then
		--网络无连接
		showMsg = "当前网络连接异常，请检查网络设置"
	elseif code == 28 then
		showMsg = "网络连接超时，请重试"
	elseif code == 52 then
		showMsg = "获取数据失败了，请检查网络再试试吧"
	elseif not msg then
		showMsg = "网络连接异常,请稍后重试"
	else
		showMsg = msg
	end
	showToast(showMsg.."("..code..")")
end

function HttpClient:getToken( func )
	local sharedDirector = cc.Director:getInstance()
    local runningScene = sharedDirector:getRunningScene()

	if func then
		self.callb_func = func
	end
    self:onSuccessCallBack(function (dataTable)
        DataTokenInstance:getInstance():onSucess(dataTable)
        if self.callb_func then
        	self.callb_func()
        end
    end)
    :doPost(Res.interface.tokeninfo, BasicParamModel.new({}))
    :showLoadingView(runningScene)
    :start()
end

return HttpClient