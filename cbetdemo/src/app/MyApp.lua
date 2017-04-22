
local MyApp = class("MyApp", cc.load("mvc").AppBase)

-- require("app.contacts.Res")

-- UserInfo = require("app.util.Cbet_UserInfo")
-- GameState = import("framework.cc.utils.GameState")
-- ImageCacheManager = require("app.net.ImageCacheManager")

function MyApp:onCreate()
    math.randomseed(os.time())
end

return MyApp
