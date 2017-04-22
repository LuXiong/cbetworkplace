--
-- Author: meixx
-- Date: 2016-07-25 16:14:35
--
--[[
 dataToken单例
]]--
DataTokenInstance = {}

function DataTokenInstance:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function DataTokenInstance:getInstance()

	--初始化单例
	if not self.instance  then
		--密钥
		self.privateKey = nil
		--密钥
		self.secret = nil
		self.key  = nil
		--加密类型
		self.type = nil
		--有效时间戳
		self.timpStamp = 0
		--有效时间
		self.ttl = 0
		self.instance = self:new()
	end
	return self.instance
end

--[[
  --检查token 是否有效 无效重新获取
]]
function DataTokenInstance:checkTokenState()
	if not self:isTokenValid() then
		-- print("checkTokenState--->>>>>>>> is valid ")
		--Token无效重新获取
		self:requestToken()
	else
		-- print("checkTokenState--->>>>>>>> is not valid ")
	end
end

--[[
  判断Token是否有效
]]--
function DataTokenInstance:isTokenValid()
	local isValid = false
	--获取当前时间 最小单位 秒
	local currentTime = os.time()
	-- print("isTokenValid",self.privateKey,(self.timpStamp + self.ttl)>currentTime)
	--私钥不为空 且在有效时间内
	if self.privateKey and (self.timpStamp + self.ttl-60*60*4)>currentTime then
		isValid = true
	end
	return isValid
end

function DataTokenInstance:requestToken()
	local url = "http://192.168.41.76:8899/tool/gettoken"
	self:netRequest(url)
end

--[[
  Post请求 可配置是否加密
]]--
function DataTokenInstance:netRequest(url)
	-- print("请求url:  "..url)
	local result = ""
	local responseData =""

	--BEGIN 网络请求响应函数 
	local function onRequestFinished(event)
			--屏蔽请求进度信息
			if event.name=="progress" then
				return
			end

			-- print("net work event name :"..event.name)
			local status = (event.name=="completed")
			local request = event.request
			if not status then
				-- print(request:getErrorCode(),request:getErrorMessage())
				self:onError(request:getErrorCode(),request:getErrorMessage())
				return
			end
			local code = request:getResponseStatusCode()
			--网络请求成功
			if code==200 then
	  			--获取网络响应内容
				responseData= request:getResponseString()
				responseData = json.decode(responseData)
				-- dump(responseData)

				if callback then
					self:onSucess(responseData)
				end
			else 
			    --网络状态码非 200 回调	
				self:onError(request:getErrorCode(),request:getErrorMessage())
			end
	end
	--END 网络请求响应函数 

	--网络请求执行前
	self:onPre()

	--初始化网络请求
	local netRequest  = network.createHTTPRequest(onRequestFinished, url, "Post")
	netRequest:start()
end

--[[
 网络请求前
]]--
function DataTokenInstance:onPre()
	-- body
	print("token request start")
end

function DataTokenInstance:onSucess(dataTable)
	local Ssecret = dataTable.token.secret
	local Stype = dataTable.token.type
	local Skey = dataTable.token.key
	local Sttl = dataTable.token.ttl
	self:updateTokenInfo(Ssecret,Stype,Skey,Sttl)
end

function DataTokenInstance:onError(code,msg)
	-- body
	-- print("token request onError  "..code.."---"..msg)
end



--[[
 更新token 相关信息
]]--
function DataTokenInstance:updateTokenInfo(psecret,ptype,pkey,pttl)
	self.secret = psecret
	self.type = ptype
	self.key = pkey
	self.ttl = pttl
	self.timpStamp = os.time()
	self.privateKey = self:generatePrivateKey()
end

--[[
  生成 privatekey
]]--
function DataTokenInstance:generatePrivateKey()
	-- print("getPrivateKey  getPrivateKey",self.type,self.secret)
	if self.type == "DT1" and string.len(self.secret)>10 then
			--$secret[6:-10] + $secret[10:-6]
			local prePartSecret = string.sub(self.secret,7, string.len(self.secret)-10)
			local endPartSecret = string.sub(self.secret,11, string.len(self.secret)-6)
			print("self.secret ",prePartSecret..endPartSecret)
			return prePartSecret..endPartSecret
	 end	
	return nil;
end

--[[
	获取私钥
]]--
function DataTokenInstance:getPrivateKey()
	return self.privateKey;
end

--[[
  获取加密类型
]]--
function DataTokenInstance:getType()
	return self.type
end

--[[
  获取密钥
]]--
function DataTokenInstance:getKey()
	return self.key
end