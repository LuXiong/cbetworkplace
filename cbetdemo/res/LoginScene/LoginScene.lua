--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Scene
local Scene=cc.Node:create()
Scene:setName("Scene")

--Create Image_1
local Image_1 = ccui.ImageView:create()
Image_1:ignoreContentAdaptWithSize(false)
Image_1:loadTexture("commonSource/bg_home_10000.png",0)
Image_1:setLayoutComponentEnabled(true)
Image_1:setName("Image_1")
Image_1:setTag(11)
Image_1:setCascadeColorEnabled(true)
Image_1:setCascadeOpacityEnabled(true)
Image_1:setAnchorPoint(0.0000, 0.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Image_1)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 750.0000, height = 1334.0000})
layout:setVerticalEdge(3)
Scene:addChild(Image_1)

--Create Button_1
local Button_1 = ccui.Button:create()
Button_1:ignoreContentAdaptWithSize(false)
Button_1:loadTextureNormal("commonSource/img_translucent.png",0)
Button_1:loadTexturePressed("commonSource/img_translucent.png",0)
Button_1:loadTextureDisabled("Default/Button_Disable.png",0)
Button_1:setTitleFontSize(22)
Button_1:setTitleText("游客登录 >> ")
Button_1:setScale9Enabled(true)
Button_1:setCapInsets({x = 5, y = 11, width = 8, height = 7})
Button_1:setLayoutComponentEnabled(true)
Button_1:setName("Button_1")
Button_1:setTag(3)
Button_1:setCascadeColorEnabled(true)
Button_1:setCascadeOpacityEnabled(true)
Button_1:setPosition(375.0000, 150.8700)
layout = ccui.LayoutComponent:bindLayoutComponent(Button_1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.1131)
layout:setPercentWidth(0.2400)
layout:setPercentHeight(0.0300)
layout:setSize({width = 180.0000, height = 40.0000})
layout:setVerticalEdge(1)
layout:setLeftMargin(285.0000)
layout:setRightMargin(285.0000)
layout:setTopMargin(1163.1300)
layout:setBottomMargin(130.8700)
Scene:addChild(Button_1)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result
