
cc.FileUtils:getInstance():setPopupNotify(false)


require "app.globalRequires"
require "config"
require "cocos.init"
require "app.globalValues"


local function main()
    require("app.MyApp"):create():run("LoginScene")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
