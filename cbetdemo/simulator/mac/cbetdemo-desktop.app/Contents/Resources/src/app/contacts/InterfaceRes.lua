Res.interface = {}

--[[
	线下环境
]]
-- 主机头
Res.interface.HOST = "http://192.168.41.76:9899"
-- socket
Res.interface.socket = "ws://192.168.41.76:9999/crazybet"
-- 500登录
Res.interface.login500 = "http://passport.500boss.com/auth/index.php?action=waplogin&openid=500guess&webtype="
--虚拟玩法线下服务器
Res.interface.TTHOST = "http://192.168.41.76:2332"
--虚拟玩法猜球游戏的SOCKET
Res.interface.TTsocket = "ws://192.168.41.76:9000/vguess"

--[[
	预发布环境
]]
-- -- 主机头
-- Res.interface.HOST = "https://43.247.69.28:7899"
-- -- socket
-- Res.interface.socket = "ws://crazybet.choopaoo.com:7999/crazybet"
-- -- 500登录
-- Res.interface.login500 = "https://passport.500.com/auth/index.php?action=waplogin&openid=500guess&webtype="


--[[
	线上环境
]]
-- -- 主机头
-- Res.interface.HOST = "https://crazybet.choopaoo.com:47899"
-- -- socket
-- Res.interface.socket = "ws://crazybet.choopaoo.com:7999/crazybet"
-- -- 500登录
-- Res.interface.login500 = "https://passport.500.com/auth/index.php?action=waplogin&openid=500guess&webtype="
-- -- 虚拟玩法线上服务器
-- Res.interface.TTHOST = "https://crazybet.choopaoo.com:47799"
-- -- 虚拟玩法线上SOCKET
-- Res.interface.TTsocket = "ws://crazybet.choopaoo.com:7699/vguess"


-- app激活接口
Res.interface.activate = Res.interface.HOST.."/loading/activate"

-- 获取接口加密需要的token
Res.interface.tokeninfo = Res.interface.HOST.."/tool/gettoken"

-- app版本升级
Res.interface.app_update = Res.interface.HOST.."/loading/check_new_version"
--游客登录接口
Res.interface.login_guest = Res.interface.HOST.."/login/guest"
-- 第三方登录 ------	
-- 500登录
Res.interface.cp_user = Res.interface.HOST.."/login/cpuser"
-- 验证码
Res.interface.verifycode = Res.interface.HOST.."/verify/code"

--用户信息接口
Res.interface.longin_userinfo = Res.interface.HOST.."/user/info"
-- 查询机器人信息接口
Res.interface.longin_userinfo_v2 = Res.interface.HOST.."/user/info/v2"
-- 简单用户信息
Res.interface.simple_userinfo = Res.interface.HOST.."/simple/user/info"
-- 首页活动状态 简单点说就是小红点的状态
Res.interface.activity_info = Res.interface.HOST.."/activity/info"

--首页信息接口
Res.interface.home_info = Res.interface.HOST.."/home/info"
-- 首页排行榜
Res.interface.home_rank_list = Res.interface.HOST.."/home/ranklist"

--赛事列表 未开始或进行中接口
Res.interface.match_list_guest = Res.interface.HOST.."/match/football/list"

--赛事列表 已完赛接口
Res.interface.match_list_finish= Res.interface.HOST.."/match/football/finished"

-- 我关注的比赛列表
Res.interface.my_collection = Res.interface.HOST.."/match/football/personal"

-- 比赛收藏
Res.interface.match_list_collection = Res.interface.HOST.."/match/personal/concern"


--详情直播页面 数据统计接口
Res.interface.race_detail_data_static = Res.interface.HOST.."/match/football/stat"

--详情直播页面 事件统计接口
Res.interface.race_detail_event_data = Res.interface.HOST.."/match/football/case"

-- 直播页->购买控件：购买接口
Res.interface.buy_football = Res.interface.HOST.."/trade/gold/order"

-- 直播页->购买控件：订单查询接口
Res.interface.check_order_status = Res.interface.HOST.."/trade/gold/check"

--详情页面整体页面接口
Res.interface.rece_detail = Res.interface.HOST.."/match/football/detail" -- bet/match/football/detail

--投注记录接口
Res.interface.purchase_record = Res.interface.HOST.."/trade/gold/list"

--第三方auth接口
Res.interface.auth_login = Res.interface.HOST.."/login/cpuser"
-- 获取验证码
Res.interface.get_verifycode = Res.interface.HOST.."/verifycode/code"
-- 实名认证
Res.interface.real_name_certified = Res.interface.HOST.."/user/auth"
-- 购买蓝钻接口
Res.interface.recharge_diamond = Res.interface.HOST.."/shops/diamond/buy"
-- 商城列表接口
Res.interface.store_list = Res.interface.HOST.."/shops/props/list"
-- 道具购买接口
Res.interface.store_cargo_buy = Res.interface.HOST.."/shops/props/buy"
-- 特权购买接口
Res.interface.store_privilege_buy = Res.interface.HOST.."/shops/privileges/buy"
-- 钻石列表接口
Res.interface.diamond_list = Res.interface.HOST.."/shops/diamond/list"
-- 充值渠道列表接口
Res.interface.recharge_channel_list = Res.interface.HOST.."/recharge/list"
-- 抽奖接口
Res.interface.crazywheel_bingo = Res.interface.HOST.."/wheel/bingo"
--转盘首页信息
Res.interface.crazywheel_info = Res.interface.HOST.."/wheel/info"
-- 抽奖转盘 排行榜
Res.interface.crazywheel_rank_list = Res.interface.HOST.."/wheel/ranklist"
-- 兑换实物列表
Res.interface.shop_convert_list = Res.interface.HOST.."/shops/goods/list"
----兑换记录列表
Res.interface.shop_convert_record_list = Res.interface.HOST.."/shops/goods/exchange/record/list"
-----商城 特权
Res.interface.show_privilege_list = Res.interface.HOST.."/shops/privileges/list"
-- 未读消息接口
Res.interface.message_list = Res.interface.HOST.."/notify/pull"
-- 兑换 接口
Res.interface.goods_exchange = Res.interface.HOST.."/shops/goods/exchange"
-- 免费抽奖实物兑换 接口
Res.interface.goods_exchange_free = Res.interface.HOST.."/prize/goods/order"
-- 查询用户上次收货地址
Res.interface.get_shipping_address = Res.interface.HOST.."/shipping/address/get"
-- 添加新收货人地址信息
Res.interface.add_shipping_address = Res.interface.HOST.."/shipping/address/add"
-- 活动列表
Res.interface.activie_list = Res.interface.HOST.."/activity/list"
-- 活动读取反馈
Res.interface.active_single = Res.interface.HOST.."/activity/single"
-- 物流信息接口
Res.interface.goods_exchange_courier = Res.interface.HOST.."/logistics/get"
-- 成长之路接口
Res.interface.task_grow_list = Res.interface.HOST.."/task/growth"
-- 每周任务接口
Res.interface.task_week_list = Res.interface.HOST.."/task/perweek"
-- 领取任务奖励接口
Res.interface.task_reward = Res.interface.HOST.."/task/click/dole"
-- 分享成功后访问接口
Res.interface.task_done_share = Res.interface.HOST.."/share/callback"
Res.interface.content_share = Res.interface.HOST.."/user/share"
-- 分享消息体接口
Res.interface.content_share = Res.interface.HOST.."/user/share"
-- 签到列表接口
Res.interface.activity_signed_list = Res.interface.HOST.."/activity/sign/list"
-- 签到获取奖励接口
Res.interface.activity_signed_get = Res.interface.HOST.."/activity/market/sign"
-- 首次登陆获取奖励接口
Res.interface.activity_first_login = Res.interface.HOST.."/first/login/callback"
---------- 猜球游戏相关的接口 --------
Res.interface.crace_joinroom = Res.interface.TTHOST.."/api/join"
Res.interface.crace_makebet = Res.interface.HOST.."/vguess/place/order"
Res.interface.crace_history = Res.interface.HOST.."/vguess/matches/result/list"
--通知嘉奖列表接口
Res.interface.award_message_list = Res.interface.HOST.."/activity/prize/list"
--通知嘉奖领取接口
Res.interface.award_message_dole = Res.interface.HOST.."/activity/prize/dole"
--push switch 
Res.interface.push_switch = Res.interface.HOST.."/push/switch"
-- 邀请好友 好友列表
Res.interface.invite_friends = Res.interface.HOST.."/invite/friends"
--虚拟玩法春节活动接口
Res.interface.race_activity = Res.interface.HOST.."/vguess/ranklist"
-- 通用排行榜 中超排行榜 -------------
Res.interface.normal_match_rank_list_info = Res.interface.HOST.."/csl/ranklist"
-- 优惠活动
Res.interface.home_activity_buy = Res.interface.HOST.."/shops/gift/buy"
--概况
Res.interface.championship_survey = Res.interface.HOST.."/champion/match/list"
-- 锦标赛列表
Res.interface.championship_list = Res.interface.HOST.."/champion/list"
-- 锦标赛购买记录
Res.interface.championship_record = Res.interface.HOST.."/champion/trade/order/list"
-- 锦标赛报名
Res.interface.championship_entry = Res.interface.HOST.."/champion/match/entry"

Res.interface.championship_prize = Res.interface.HOST.."/champion/prize"

Res.interface.championship_rank = Res.interface.HOST.."/champion/user/rank"
-- 锦标赛赛事列表
Res.interface.championship_match_list = Res.interface.HOST.."/champion/match/list"
-- 锦标赛赛事详情
Res.interface.championship_match_detail = Res.interface.HOST.."/champion/detail"
-- 锦标赛分享
Res.interface.championship_show = Res.interface.HOST.."/champion/show"
-- 锦标赛赛事详情下单
Res.interface.championship_match_detail_buy_football = Res.interface.HOST.."/champion/place"
-- 锦标赛用户信息
Res.interface.championship_match_user_info = Res.interface.HOST.."/champion/user/info"
-- 增购
Res.interface.championship_rebuy = Res.interface.HOST.."/champion/rebuy"
-- 锦标赛送金币
Res.interface.championship_gift_golds = Res.interface.HOST.."/champion/gift/golds"
