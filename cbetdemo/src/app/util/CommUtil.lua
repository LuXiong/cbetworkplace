--
-- Author: meixx
-- Date: 2016-07-21 16:00:53
--

--[[
  截屏
]]--

function takeScreenShot(filename,callb)
  local fileName = filename or "printScreen.jpg"  
   -- 移除纹理缓存  
  cc.Director:getInstance():getTextureCache():removeTextureForKey(fileName)  
   -- 截屏  
  cc.utils:captureScreen(function(succeed, outputFile)  
      if succeed then
        if device.platform == "android" then
          luaAppBridge({type= Res.lua_compress_image,imgurl = outputFile},function (event)
            if callb then
              callb(outputFile)
            end
          end)
        else
          if callb then
            callb(outputFile)
          end
        end  
      else  
           cc.showTextTips("截屏失败")  
      end  
  end, fileName)
end

--[[
  多个table 合并成一个新table
]]--
function tableCombine( ... )
	local comTable = {}
	local tempTables = {...}
	for i=1,#tempTables do
		tableCopyValue(comTable,tempTables[i])
	end
	return comTable
end

--[[
  判断是否table中是否存在对应的value 存在返回true 不存在返回false
]]
function isInTable(value, tbl)
  for k,v in ipairs(tbl) do
    if v == value then
    return true;
    end
  end
  return false;
end

--[[
  计算一段字符串的长度
]]
function generateOpenHeight(str,fontSize)
  -- 计算字符串宽度
  local lenInByte = #str
  local width = 0
   
  for i=1,lenInByte do
      local curByte = string.byte(str, i)
      local byteCount = 1;
      if curByte>0 and curByte<=127 then
          byteCount = 1
      elseif curByte>=192 and curByte<223 then
          byteCount = 2
      elseif curByte>=224 and curByte<239 then
          byteCount = 3
      elseif curByte>=240 and curByte<=247 then
          byteCount = 4
      end
       
      local char = string.sub(str, i, i+byteCount-1)
      i = i + byteCount -1
       
      if byteCount == 1 then
          width = width + fontSize * 0.5
      else
          width = width + fontSize
          print(char)
      end
  end
  return width
end

--[[
	把fromTable中的数据合并到 targetTable中 
	如果 key 是数字类型 添加到最后 
	如果 key 是字符类型 在targetTable中含有相同key的键值对，直接覆盖
]]
function tableCopyValue(targetTable,fromTable)
	for k,v in pairs(fromTable) do
		--如果key是数字类型并在 targetTable中存在 直接添加到 targetTable 结尾
		if type(k)=="number"then
			if targetTable[k]  then
				table.insert(targetTable,v)
			else
				targetTable[k] = v
			end
		else
		--如果key不是数字类型 无论targetTable中是否有对应 key-value 直接覆盖
			targetTable[k] = v
		end
	end
end

--[[
 截取url中图片名称
]]--
function cutPicNameFromUrl(imgUrl)
  local cutName = nil
  if type(imgUrl)=="string" then
    local start,en = string.find(string.reverse(imgUrl),"/")
    if start then
      cutName = string.sub(imgUrl,string.len(imgUrl)-start+2)
      local cstart,cend = string.find(cutName,".")
      if not cstart then
       cutName = nil
       end
    end
  end
  return cutName
end

--[[
   url decode 中文 特殊符号 解码
]]--
function URLdecode(s)
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
    return s
end

--url encode 中文 特殊符号 转码
function URLencode(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

--[[
  类构造基本设置
  主要用于构建单利
]]--
function structureClass(moduleName)  
    local obj = {}  
    setmetatable(obj,{__index = moduleName})  
    return obj    
end  

function StringSplit(str, separator)  
  if not str then
    return nil
  end
  local nFindStartIndex = 1  
  local nSplitIndex = 1  
  local nSplitArray = {}  
  while true do  
     local nFindLastIndex = string.find(str, separator, nFindStartIndex)  
     if not nFindLastIndex then  
      nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, string.len(str))  
      break  
     end  
     nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, nFindLastIndex - 1)  
     nFindStartIndex = nFindLastIndex + string.len(separator)  
     nSplitIndex = nSplitIndex + 1  
  end  
  return nSplitArray  
end 

--[[
  模仿toast提示
]]--
function showToast(string_msg)
  local currentScene = cc.Director:getInstance():getRunningScene()
  currentScene:performWithDelay(function()

      if currentScene.toastbg then
          local lblmsg = currentScene.toastbg:getChildByTag(1000)
          lblmsg:setString(string_msg)
          currentScene.toastbg:stopAllActions()
          currentScene.toastbg:show()
      else
          --创建toast背景
          currentScene.toastbg = cc.ui.UIImage.new(Res.img_toast_bg,{scale9 = true,size = cc.size(display.width, 90)})
                          :align(display.CENTER, display.cx, display.cy)
                          :addTo(currentScene,102199)
          ----toast最小宽高
          local minWidth = 500
          local minHeight = 100
          --信息显示标签
          local lbl_msg = cc.ui.UILabel.new({text=string_msg,align = cc.ui.TEXT_ALIGN_CENTER,dimensions = cc.size(minWidth, 0),size = Res.font_size_t7,color = display.COLOR_WHITE})
                          :addTo(currentScene.toastbg)
          local lbSize = lbl_msg:getContentSize()
          local lbWidth = lbSize.width
          local lbHeight = lbSize.height
          if lbSize.width > (minWidth -20*2) then
            minWidth = ((lbSize.width + 20*2) >display.width) and display.width or lbSize.width + 20*2
          end

          if lbSize.height > (minHeight -10*2) then
            minHeight = ((lbSize.height + 10*2) >display.height) and display.height or lbSize.height + 20*2
          end

          --设置toast 大小
          currentScene.toastbg:setContentSize(minWidth,minHeight)
          lbl_msg:align(display.CENTER, currentScene.toastbg:getContentSize().width/2, currentScene.toastbg:getContentSize().height/2)
          lbl_msg:setTag(1000)
      end

      -- toast显示动画
      local actionFadeIn = cc.FadeIn:create(1.5)
      local actionFadeOut = cc.FadeOut:create(1.5)
      local sequence = cc.Sequence:create(actionFadeIn,actionFadeOut)

      transition.execute(currentScene.toastbg,sequence,{onComplete = function()
          currentScene.toastbg:hide()
        end})
        
    end, 0.5)
end

function trim (s)
  if not s then
    return nil
  end
    return string.match(s, "^%s*(.-)%s*$")
end

--解析星期 2016-08-01 02:00
-- %a    abbreviated weekday name (e.g., Wed)
-- %A    full weekday name (e.g., Wednesday)
-- %b    abbreviated month name (e.g., Sep)
-- %B    full month name (e.g., September)
-- %c    date and time (e.g., 09/16/98 23:48:10)
-- %d    day of the month (16) [01-31]
-- %H    hour, using a 24-hour clock (23) [00-23]
-- %I    hour, using a 12-hour clock (11) [01-12]
-- %M    minute (48) [00-59]
-- %m    month (09) [01-12]
-- %p    either "am" or "pm" (pm)
-- %S    second (10) [00-61]
-- %w    weekday (3) [0-6 = Sunday-Saturday]
-- %x    date (e.g., 09/16/98)
-- %X    time (e.g., 23:48:10)
-- %Y    full year (1998)
-- %y    two-digit year (98) [00-99]
function parseDate(strDate,hasWeekDay,showTomorrow)
  strDate = trim(strDate)
  if not strDate then
    return ""
  end
  -- strDate = string.gsub(strDate, Res.constant.dash, Res.constant.backSlash)
  local weekday = ""
  local timeTab = {}
  local weekdayArray = {Res.str_weekday_array.Sunday,Res.str_weekday_array.Monday,Res.str_weekday_array.Tuesday,Res.str_weekday_array.Wednesday,Res.str_weekday_array.Thursday,Res.str_weekday_array.Friday,Res.str_weekday_array.Saturday}
  local dateArray=StringSplit(string.match(strDate, "%d+-%d+-%d+"),Res.constant.dash)--string.match(strDate, "%d+-%d+-/%d+")
  local timeArray=StringSplit(string.match(strDate, "%d+:%d+"),Res.constant.colon)--string.match(strDate, "%d+:%d+")

  -- local dateArray=StringSplit(strDate,Res.constant.dash)
  if not dateArray or not timeArray then
    return ""
  end
  local dateTemp = dateArray[1]..Res.str_year..dateArray[2]..Res.str_month..dateArray[3]..Res.str_day
  if not hasWeekDay then
    return dateTemp
  end

  timeTab.year=dateArray[1]
  timeTab.month=dateArray[2]
  timeTab.day=dateArray[3]
  timeTab.hour=timeArray[1]
  timeTab.min=timeArray[2]
  local customDate = os.date("%x",os.time(timeTab))
  local customYear = os.date("%Y",os.time(timeTab))
  local customMonth = os.date("%m",os.time(timeTab))
  local customDay = os.date("%d",os.time(timeTab))

  local currentDate = os.date("%x")
  local currentYear = os.date("%Y")
  local currentMonth = os.date("%m")
  local currentDay = os.date("%d")
  
  if currentDate == customDate then
    weekday = Res.str_today
  elseif showTomorrow and customYear == currentYear and customMonth == currentMonth and customDay == tostring(checknumber(currentDay)+1) then
    weekday = Res.str_tomorrow
  else
    local weekdayIndex = os.date("%w",os.time(timeTab))
    weekday = weekdayArray[tonumber(weekdayIndex)+1]
  end

  return dateTemp.." "..weekday
end

--[[
  格式短日期
  strDate eg格式:2017-04-12 18:00

  返回  eg：今天 18:00
            04.12 18:00
]]--
function parseShortDate(strDate)
  strDate = trim(strDate)
  if not strDate then
    return ""
  end
  -- strDate = string.gsub(strDate, Res.constant.dash, Res.constant.backSlash)
  local timeTab = {}
  local dateArray=StringSplit(string.match(strDate, "%d+-%d+-%d+"),Res.constant.dash)--string.match(strDate, "%d+-%d+-/%d+")
  local timeArray=StringSplit(string.match(strDate, "%d+:%d+"),Res.constant.colon)--string.match(strDate, "%d+:%d+")

  -- local dateArray=StringSplit(strDate,Res.constant.dash)
  if not dateArray or not timeArray then
    return ""
  end
  local dateTemp = dateArray[2].."/"..dateArray[3]
  local hourTemp = timeArray[1]..":"..timeArray[2]

  timeTab.year=dateArray[1]
  timeTab.month=dateArray[2]
  timeTab.day=dateArray[3]
  timeTab.hour=timeArray[1]
  timeTab.min=timeArray[2]

  local customDate = os.date("%x",os.time(timeTab))
  local customYear = os.date("%Y",os.time(timeTab))
  local customMonth = os.date("%m",os.time(timeTab))
  local customDay = os.date("%d",os.time(timeTab))

  local currentDate = os.date("%x")
  local currentYear = os.date("%Y")
  local currentMonth = os.date("%m")
  local currentDay = os.date("%d")
  
  if currentDate == customDate then
    dateTemp = Res.str_today
  elseif customYear == currentYear and customMonth == currentMonth and customDay == tostring(checknumber(currentDay)+1) then
    dateTemp = Res.str_tomorrow
  end

  return dateTemp.." "..hourTemp
end

function strlength(str)
    -- 计算字符串长度，中英文混合
    str = string.gsub(str, "%%", " ") -- 将%替换成" "
    local str = string.gsub(str, "[\128-\191]","")
    local _,ChCount = string.gsub(str, "[\192-\255]","")
    local _,EnCount = string.gsub(str, "[^\128-\255]","")
    return ChCount + EnCount
end

function copy_table(ori_tab)
    if type(ori_tab) ~= "table" then
        return
    end
    local new_tab = {}
    for k,v in pairs(ori_tab) do
        local vtype = type(v)
        if vtype == "table" then
            new_tab[k] = copy_table(v)
        else
            new_tab[k] = v
        end
    end
    return new_tab
end

-- 获得字符串和缩略形式
-- str 原字符串
-- length 限定长度
-- 
function string.thumbnail(str,length,suffix)
  local str_final = ""
  local str_suffix = suffix or "..."
    if string.len(str) == 0 then
        return str_final
    end

    local i_index = 1
    local i_gap = 1

    for i=1,string.len(str) do
        local str_sub = ""
        if i == i_index and i <= length then
            str_sub = string.sub(str,i,i)
            i_gap = 1
            i_index = i + i_gap
            if string.byte(str_sub) > 127 then
                length = length + 1.3
                -- 为汉字
                str_sub = string.sub(str,i,i+2)
                i_gap = 3
                i_index = i + i_gap
            elseif (string.byte(str_sub)>=65 and string.byte(str_sub)<=90) then
                length = length - 3/11
            elseif string.byte(str_sub) == 64 then
                length = length - 0.7
            end 
            str_final = str_final..str_sub
        end
        -- print("------------------sub string value is",string.byte(str_sub),"str_sub = ",str_sub,"i = ",i,"length = ",length,"i_index = ",i_index,"string length is = ",string.len(str))
    end

    print("length = ",length,"-----------------------")
    if str == str_final then
        str_final = str
    elseif string.len(str) == string.len(str_final) + 1 then
        str_final = str
    elseif string.len(str) > length then
        str_final = str_final..str_suffix
    end

    return str_final
end

--[[
  lua 调用app平台方法 
  type 必传  
             -- lua 通知app升级版本 Res.lua_action_appupdate = "lua_action_appupdate"      无返回值
             -- lua 获取app版本号   Res.lua_action_app_version = "lua_action_app_version"  返回值 {version="1.0.0"}
  参考
  { 
    type="xxx"
  }
]]--
function luaAppBridge(params,call_func)
    if device.platform =="android" then
        androidLocalMethod(params,call_func)
    elseif device.platform =="ios"  then
      -- if params.type==Res.lua_action_jpush_rgid then
      --   if call_func then
      --      call_func({result="100",id="10000"})
      --   end
      -- else
        iosLocalMethod(params,call_func)
      -- end
    else
      if params.type==Res.lua_action_app_version then
         if call_func then
           call_func({version="1.1.3",channelId="windows"})
         end
      elseif params.type==Res.lua_action_jpush_rgid then
        if call_func then
           call_func({result="100",id="10000"})
        end
      else
        showToast("非移动平台,暂不支持当前操作")
      end
      
  end
end

function androidLocalMethod(params,call_func)
      local javaClassName = "org/cocos2dx/lua/AppActivity"
      local listener = function (event)
        if type(event) == "string" then
              event = json.decode(event)
              call_func(event)
        end
      end
      local jsonStr = json.encode(params)
      local state = luaj.callStaticMethod(javaClassName, "luaCallApp", {jsonStr,listener}, "(Ljava/lang/String;I)V")
end

--金额加逗号 可以传入 数字或者字符串 例如 ”10000“ or 10000 都可以 转化为 10,000 空字符串或者nil自动转化为 0 
function seprateNumber(number)
  local count  = checknumber(number)
  local i = 0
  local tb_separt = {}
  local result = ""
  while count/1000 >= 1 do
    local more = count%1000
    more = string.format("%03d",more)
    count = math.floor(count/1000)
    table.insert(tb_separt,more)
  end
  if count>=0 then
    count = string.format("%d",count)
    table.insert(tb_separt,count)
  end

  for i = #tb_separt, 1, -1 do
    if i ~= #tb_separt then
      result = tostring(result)..","..tostring(tb_separt[i])
    else
      result = tostring(tb_separt[i])
    end
  end
  return result
end

function iosLocalMethod(params,call_func)
    print("iosLocalMethod luaCallApp")
    local  ocClassName = "AppHelper"
      local listener = function (event)
          if type(event) == "string" then
            event = json.decode(event)
            call_func(event)
          end
      end
      params.callback = listener
      local state = luaoc.callStaticMethod(ocClassName, "luaCallApp", params) 
      print("第三方支付插件调用状态",string_method,state) 
end
--判断point是否在目标view内部
function rectContainsPointByWorld(worldPoint,targetNode,cascadeBound)
  local startPoint = targetNode:convertToWorldSpace(cc.p(0,0))
  local boundingBox = cascadeBound and targetNode:getCascadeBoundingBox() or targetNode:getBoundingBox()
  local newRect = cc.rect(startPoint.x,startPoint.y,boundingBox.width,boundingBox.height)
  if cc.rectContainsPoint(newRect, worldPoint) then
      return true
  end
  return false
end
---相对坐标
-- function rectContainsPointByWorld(worldPoint,targetNode,cascadeBound)
--   local startPoint = targetNode:convertToNodeSpace(worldPoint)
--   local boundingBox = cascadeBound and targetNode:getCascadeBoundingBox() or targetNode:getBoundingBox()
--   local newRect = cc.rect(0,0,boundingBox.width,boundingBox.height)
--   if cc.rectContainsPoint(newRect, startPoint) then
--       return true
--   end
--   return false
-- end

function rectContainsPointByNode(nodePoint,targetNode,cascadeBound)
  local worldPoint = targetNode:convertToWorldSpace(nodePoint)
  return rectContainsPointByWorld(worldPoint,targetNode,cascadeBound)
end

function showFirework(iconShow)
    MusicConfig.playSound(Res.sound_goldpull)
    local layer = cc.Layer:create()
    if iconShow then
      local successIcon = cc.ui.UIImage.new(Res.img_shop_cargo_success)
                          :align(display.CENTER, display.cx, display.cy)
                          :addTo(layer,0)
    end
    local emitter = cc.ParticleFireworks:createWithTotalParticles(10000)
    -- emitter:retain()
    layer:addChild(emitter, 0)
    --//设置每秒钟产生粒子的数量
    emitter:setEmissionRate(100)
    --//设置发射粒子的持续时间-1表示永远持续  
    emitter:setDuration(1.5)
    --//设置开始时候粒子大小以及偏差
    emitter:setStartSize(45)
    emitter:setStartSizeVar(0) 
    --//设置开始时候的颜色以及偏差  
    emitter:setStartColor(cc.c4f(255,255,255,255))
    emitter:setEndColor(cc.c4f(255,255,255,255))
    --//设置粒子开始时候旋转角度以及偏差   //设置结束时候的旋转角度以及偏差 
    emitter:setStartSpin(0)
    emitter:setEndSpin(60)
    --粒子发射速度
    emitter:setSpeed(2000)
    --//设置径向加速度以及偏差 
    emitter:setRadialAccel(0)
    emitter:setRadialAccelVar(0)
    --//设置粒子的切向加速度以及偏差  
    emitter:setTangentialAccel(0)
    emitter:setTangentialAccelVar(0)
    --//设置粒子生命期以及偏差 
    emitter:setLife(10)
    emitter:setLifeVar(0) 
    --旋转角度
    emitter:setRotation(0)
    --//设置角度以及偏差
    emitter:setAngle(90)
    emitter:setAngleVar(12)
    --//设置粒子的重力方向 
    emitter:setGravity(cc.p(0,-1600))
    emitter:setTexture(cc.Director:getInstance():getTextureCache():addImage(Res.img_shop_animation_gold))
    emitter:setPosition(display.cx,-280)

    layer:addTo(display.getRunningScene(),10)

    display.getRunningScene():performWithDelay(function()
            layer:removeSelf()
        end, 4)
    -- return layer
end