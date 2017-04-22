--
-- Author: xlook
-- Date: 2017-04-19 11:19:45
--
function generateRealHeight(ctrl,screenHeight,designHeight)
	local f_fixedHeight

	local component = ctrl:getComponent("__ui_layout")

	if component:getVerticalEdge() == 1 or component:getVerticalEdge() == 0 then -- 靠近底层
		f_fixedHeight = ctrl:getPositionY()

	elseif component:getVerticalEdge() == 2 then -- 靠近顶层
		f_fixedHeight = screenHeight - (designHeight - ctrl:getPositionY())

	elseif component:getVerticalEdge() == 3 then -- 中心对齐
		f_fixedHeight = ctrl:getPositionY()*screenHeight/designHeight
	end

	ctrl:setPositionY(f_fixedHeight)
end
