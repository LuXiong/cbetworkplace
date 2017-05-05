
local MyApp = class("MyApp", cc.load("mvc").AppBase)

-- require("app.contacts.Res")

-- UserInfo = require("app.util.Cbet_UserInfo")
-- GameState = import("framework.cc.utils.GameState")
-- ImageCacheManager = require("app.net.ImageCacheManager")

-- GameState.init(function(param)
--     local returnValue = nil
--     if param.errorCode then
--         print("error code" .. param.errorCode)
--     else
--         --crypto
--         if param.name == "save" then
--             local str = json.encode(param.values)
--             str = crypto.encryptXXTEA(str,"abcd")--使用XXT加密算法
--             returnValue = {data = str}
--         elseif param.name == "load" then
--             local str = param.values.data
--             local str = crypto.decryptXXTEA(param.values.data,"abcd")
--             returnValue = json.decode(str)
--         end
--     end
--     return returnValue    
-- end,"data.txt","abcd") --保存到writablePath下data.txt文件中，加密口令"abcd"

function MyApp:onCreate()
    math.randomseed(os.time())
end

return MyApp
