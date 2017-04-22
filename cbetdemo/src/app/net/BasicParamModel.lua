--
-- Author: meixx
-- Date: 2016-07-21 11:57:41
--
--[[
	请求参数类
]]--
local BasicParamModel = class("BasicParamModel")

function BasicParamModel:ctor(params)
	self.publicParam = self:getPublicParams()
	self.modelParam = params
end

function BasicParamModel:getRequestParams()
	return tableCombine(self.publicParam,self.modelParam)
end

function BasicParamModel:getPublicParams()
	local params = {
		platform = device.platform == "windows" and "android" or device.platform,
		channel = channelId,
		version = app_version or gameData.version,
		deviceid = "abcdefghijklmnopqrstuvwxyz",--device.getOpenUDID(),
		idfa = idfaCode or ""
	}
	if gameData.userInfo and gameData.userInfo.ck then
		params.ck = gameData.userInfo.ck --"MTAwMTQ1ODNhYmU0YzBkMzQ4MjhiZDA1YTlkMDAwNTRiYTdlNmU2"--
		-- print("params.ck: "..params.ck)
	end
	return params
end

-- 在使用Socket发送消息时，使用此方法来获取完整的请求信息
function BasicParamModel:getParamStr()
	return self:generateTableToJson(self:getRequestParams())
end

function BasicParamModel:generateTableToJson(table)
	local params = table
	local paramStr = ""
	for k,v in pairs(params) do
		k = "\""..k.."\""
		if v == "{}" or type(v) == "table" then
			v = self:generateTableToJson(v)
		else
			v = "\""..tostring(v).."\""
		end
		if #paramStr > 0 then
			paramStr = paramStr..","..k..":"..v
		else
			paramStr = k..":"..v
		end
	end
	print("BasicParamModel->{"..paramStr.."}")
	return "{"..paramStr.."}"
end

return BasicParamModel