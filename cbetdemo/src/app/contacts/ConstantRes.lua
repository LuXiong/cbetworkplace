
Res.constant={}

Res.website = "http://www.choopaoo.com"

Res.constant.underline = "_"
Res.constant.dash = "-"
Res.constant.colon = ":"
Res.constant.slash = "\\"
Res.constant.backSlash = "/"
Res.constant.plus = "+"
Res.constant.apostrophe = "'"
Res.constant.RMB = "¥"

--赛事状态 无状态
Res.constant.match_status_no_status = "0"
--赛事状态 未开始
Res.constant.match_status_no_start = "1"
--赛事状态 上半场
Res.constant.match_status_first_half = "2"
--赛事状态 中场休息
Res.constant.match_status_half = "4"
--赛事状态 下半场
Res.constant.match_status_second_half = "8"
--赛事状态 完场
Res.constant.match_status_finish = "16"
--赛事状态 常规时间完结
Res.constant.match_status_regular_finish = "32"
--赛事状态 加时上半场
Res.constant.match_status_extra_first_half = "64"
--赛事状态 加时中场休息
Res.constant.match_status_extra_half = "128"
--赛事状态 加时下半场
Res.constant.match_status_extra_second_half = "256"
--赛事状态 加时完场
Res.constant.match_status_extra_finish = "512"
--赛事状态 点球大战
Res.constant.match_status_penalty_shootout = "1024"

--     -- "1"： # 开放，可购买
--     -- "2":  # 临时关闭（封盘）
--     -- "3":  # 关闭
--     -- "4":  # 市场结算
--     -- "7"： # 手动操作
--开放，可购买
Res.constant.market_state_open = "1"
--临时关闭
Res.constant.market_state_pause = "2"
--关闭
Res.constant.market_state_close = "3"
--市场结算
Res.constant.market_state_calculate = "4"
--手动操作
Res.constant.market_state_manual = "7"

--赛事状态 未开始
Res.constant.match_state_no_start = "0"
--赛事状态 完场
Res.constant.match_state_finish = "1"
--赛事状态 取消
Res.constant.match_state_cancel = "2"
--赛事状态 进行中
Res.constant.match_state_running = "3"
--赛事状态 暂停
Res.constant.match_state_suspend = "4"
--赛事状态 取缔
Res.constant.match_state_abandon = "5"

--进球数市场
Res.constant.rule_type_goal 	= "310"
--胜平负市场
Res.constant.rule_type_win		= "100"
--角球市场
Res.constant.rule_type_corner	= "320"
--下一个进球市场
Res.constant.rule_type_nextGoal = "350"
--单双市场
Res.constant.rule_type_oddEven = "130"
--进球数市场
Res.constant.rule_type_numberGoal = "410"
--比分市场
Res.constant.rule_type_score = "140"

Res.constant.eventType = {}

Res.constant.eventType.HOME_CONTROL           = "101051"              -- 控球
Res.constant.eventType.HOME_ATTACT            = "101024"              -- 进攻
Res.constant.eventType.HOME_DANGER_ATTACT     = "101026"              -- 危险进攻
Res.constant.eventType.HOME_SHOTGOAL          = "101039"              -- 射正球门
Res.constant.eventType.HOME_SHOTOFFGOAL       = "101040"              -- 射偏球门
Res.constant.eventType.HOME_OFFSIDE          = "101043"              -- 越位
Res.constant.eventType.HOME_THROWIN           = "101054"              -- 界外球
Res.constant.eventType.HOME_PENALTYKICK       = "101031"              -- 点球
Res.constant.eventType.HOME_EXCHANGE          = "101055"              -- 换人
Res.constant.eventType.HOME_GOALKICK          = "101053"              -- 球门球
Res.constant.eventType.HOME_FREEKICK          = "101028"              -- 任意球
Res.constant.eventType.HOME_DANGER_FREEKICK   = "101027"              -- 危险任意球
Res.constant.eventType.HOME_CORNERKICK        = "101025"              -- 角球
Res.constant.eventType.HOME_GOAL              = "101029"              -- 主队进球
Res.constant.eventType.HOME_CANCEL_GOAL       = "101030"              -- 取消主队进球
Res.constant.eventType.HOME_REDCARD           = "101032"              -- 红牌
Res.constant.eventType.HOME_YELLOWCARD        = "101034"              -- 黄牌

Res.constant.eventType.AWAY_CONTROL           = "102075"              -- 控球
Res.constant.eventType.AWAY_ATTACT            = "102048"              -- 进攻
Res.constant.eventType.AWAY_DANGER_ATTACT     = "102050"              -- 危险进攻
Res.constant.eventType.AWAY_SHOTGOAL          = "102063"              -- 射正球门
Res.constant.eventType.AWAY_SHOTOFFGOAL       = "102064"              -- 射偏球门
Res.constant.eventType.AWAY_OFFSIDE          = "102067"              -- 越位
Res.constant.eventType.AWAY_THROWIN           = "102078"              -- 界外球
Res.constant.eventType.AWAY_PENALTYKICK       = "102055"              -- 点球
Res.constant.eventType.AWAY_EXCHANGE          = "102079"              -- 换人
Res.constant.eventType.AWAY_GOALKICK          = "102077"              -- 球门球
Res.constant.eventType.AWAY_FREEKICK          = "102052"              -- 任意球
Res.constant.eventType.AWAY_DANGER_FREEKICK   = "102051"              -- 危险任意球
Res.constant.eventType.AWAY_CORNERKICK        = "102049"              -- 角球
Res.constant.eventType.AWAY_GOAL              = "102053"              -- 客队进球
Res.constant.eventType.AWAY_CANCEL_GOAL       = "102054"              -- 取消客队进球
Res.constant.eventType.AWAY_REDCARD           = "102056"              -- 红牌
Res.constant.eventType.AWAY_YELLOWCARD        = "102058"              -- 黄牌

Res.constant.eventType.BILLBOARD_FST_START    = "100010"               -- 上半场开始
Res.constant.eventType.BILLBOARD_FST_END      = "100001"               -- 上半场结束
Res.constant.eventType.BILLBOARD_SND_START    = "100012"               -- 下半场开始
Res.constant.eventType.BILLBOARD_SND_END      = "100003"               -- 下半场结束
Res.constant.eventType.BILLBOARD_THD_END      = "100005"               -- 结束加时赛上半场（加时赛中场）
Res.constant.eventType.BILLBOARD_FTH_START    = "100006"               -- 开始加时赛下半场
Res.constant.eventType.BILLBOARD_FTH_END      = "100007"               -- 结束加时赛下半场
Res.constant.eventType.BILLBOARD_PAUSE        = "100149"               -- 比赛暂停
Res.constant.eventType.BILLBOARD_RESUME       = "100148"               -- 重新开始
Res.constant.eventType.BILLBOARD_INJURY_TIME  = "billBoard"            -- 伤停补时
Res.constant.eventType.BILLBOARD_PENAL_START  = "100008"               -- 点球大战
Res.constant.eventType.BILLBOARD_PENAL_END    = "100009"               -- 点球结束

Res.constant.eventType.HOME_CONFIRM_GOAL   		= "101065"               -- 确认主队进球
Res.constant.eventType.AWAY_CONFIRM_GOAL   		= "102089"               -- 确认客队进球
Res.constant.eventType.EXTRA_FIRST_START    	= "100014"               -- 开始加时上半场
Res.constant.eventType.EXTRA_SECOND_START    	= "100016"               -- 开始加时下半场
Res.constant.eventType.PENALTY_SHOOTOUT_START  	= "100018"               -- 开始点球
Res.constant.eventType.MATCH_FINISH    			= "100020"               -- 比赛结束
Res.constant.eventType.MATCH_CANCEL    			= "100782"               -- 取消比赛

--  比赛列表 热门 比赛事件及提示信息对比
Res.tb_event_info = {
	["101031"] = "主队 点球",
	["101025"] = "主队 角球",
	["101029"] = "主队 进球",
	["101030"] = "取消 主队进球",
	["101032"] = "主队 红牌",
	["101034"] = "主队 黄牌",
	["102055"] = "客队 点球",
	["102049"] = "客队 角球",
	["102053"] = "客队 进球",
	["102054"] = "取消 客队进球",
	["102056"] = "客队 红牌",
	["102058"] = "客队 黄牌",
	["100141"] = "比赛开始",
	["100010"] = "比赛开始 (主队 开球)",
	["100011"] = "比赛开始 (客队 开球)",
	["100001"] = "中场休息",
	["100012"] = "下半场开始",
	["100013"] = "下半场开始",
	["100003"] = "下半场结束",
	["100014"] = "上半场加时开始",
	["100005"] = "上半场加时结束",
	["100016"] = "下半场加时开始",
	["100006"] = "下半场加时开始",
	["100007"] = "下半场加时结束",
	["100149"] = "比赛暂停",
	["100008"] = "点球大战",
	["100018"] = "点球大战开始",
	["100009"] = "点球大战结束",
	["101065"] = "主队 进球",--"确认主队进球",
	["102089"] = "客队 进球",--"确认客队进球",
	["100020"] = "比赛结束",
	["100782"] = "比赛取消"
}




Res.constant.playType = {}
Res.constant.playType.result = {}
Res.constant.playType.result.w = "1"        ---玩法结果
Res.constant.playType.result.d = "0"        ---玩法结果
Res.constant.playType.result.l = "-1"        ---玩法结果

----进球数玩法投注项-位置序号对照表
Res.constant_goals_index = {"1","2","3","4","5","6","7","-1"}
Res.constant_goals_name = {"0","1","2","3","4","5","6","7+"}
----比分玩法投注项-位置序号对照表
Res.constant_score_index = {"10001","10002","10003","10004","10005","10006","10007",
							"20001","20002","20003","20004","20005","20006","20007",
							"30001","30002","30003","30004","30005","30006","30007",
							"40001","40002","40003","40004","40005","40006","40007",
							"50001","50002","50003","50004","50005","50006","50007",
							"60001","60002","60003","60004","60005","60006","60007",
							"70001","70002","70003","70004","70005","70006","70007",
							"2","3","4"}
Res.constant_score_name = {"0-0","1-0","2-0","3-0","4-0","5-0","6-0",
							"0-1","1-1","2-1","3-1","4-1","5-1","6-1",
							"0-2","1-2","2-2","3-2","4-2","5-2","6-2",
							"0-3","1-3","2-3","3-3","4-3","5-3","6-3",
							"0-4","1-4","2-4","3-4","4-4","5-4","6-4",
							"0-5","1-5","2-5","3-5","4-5","5-5","6-5",
							"0-6","1-6","2-6","3-6","4-6","5-6","6-6",
							"胜其它","平其它","负其它"}
Res.constant_score_win_index = {"10001","10002","10003","10004","10005","10006","10007",
							"20002","20003","20004","20005","20006","20007",
							"30003","30004","30005","30006","30007",
							"40004","40005","40006","40007",
							"50005","50006","50007",
							"60006","60007",
							"70007",
							"2","3"}

-------------------疯狂猜球  BEGIN-----------
--阶段标识
Res.constant.CZ_STAGE_ONE = 1
Res.constant.CZ_STAGE_TWO = 2
Res.constant.CZ_STAGE_THREE = 3

--事件 建立连接  init
Res.constant.CZ_EVENT_INIT = "2000"

-- 分组情况展示 matches
Res.constant.CZ_EVENT_MATCHES= "2001"
--事件 准备投注播放 比赛放置桌面动画  prepare_bet
Res.constant.CZ_EVENT_PREPARE = "2002"
--事件 开始投注 start_bet
Res.constant.CZ_EVENT_START_BET = "2003"
--事件 开始投注 stop_bet
Res.constant.CZ_EVENT_END_BET = "2004"
--事件 开始模拟动画 start_analog
Res.constant.CZ_EVENT_START_ANIM = "2005"
--事件 开始结算
Res.constant.CZ_EVENT_INPAY_START = "2006"
--事件 结算结束 给用户飞金币
Res.constant.CZ_EVENT_INPAY_END = "2007"
--事件 封盘
Res.constant.CZ_EVENT_ENDSEALING = "2008"
--事件 恢复数据
Res.constant.CZ_EVENT_RECOVERY = "2009"
--事件 用户下单消息
Res.constant.CZ_EVENT_USER_BET = "2010"
--事件 聊天消息
Res.constant.CZ_EVENT_USER_TALK = "2011"
--事件 用户进入
Res.constant.CZ_EVENT_USER_IN = "2012"
--事件 用户退出
Res.constant.CZ_EVENT_USER_OUT = "2013"
--事件 剔出用户
Res.constant.CZ_EVENT_SHOT_OFF = "2016"
--事件 非法的房间号 拒绝
Res.constant.CZ_EVENT_FORBIDEN = "2017"
--事件 开始投注提示
Res.constant.CZ_EVENT_START_BET_TIP = "2019"
--事件 开始比赛提示
Res.constant.CZ_EVENT_START_ANIM_TIP = "2020"
--事件 结束提示
Res.constant.CZ_EVENT_ANIM_END_TIP = "2021"

-------------------疯狂猜球  END--------------------


----用户类型-----
-- 游客
Res.USER_GUEST = "guest"
--500
Res.USER_TYPE_500 = "500"
--微信
Res.USER_TYPE_WX = "wechat"
--QQ
Res.USER_TYPE_QQ = "qq"
--奇虎360
Res.USER_TYPE_QIHU360 = "360"

------------------蓝钻类型
-- 1 颗蓝钻 0.01 元钱
Res.STORE_DIAMON_TYPE_C1 = "1007" 
-- 6 颗蓝钻 6 元钱
Res.STORE_DIAMON_TYPE_C6 = "1001" 
-- 30 颗蓝钻 30 元钱
Res.STORE_DIAMON_TYPE_C30 = "1002"
-- 100 颗蓝钻 100 元钱
Res.STORE_DIAMON_TYPE_C100 = "1003"
-- 200 颗蓝钻 200 元钱
Res.STORE_DIAMON_TYPE_C200 = "1004" 
-- 500 颗蓝钻 500 元钱
Res.STORE_DIAMON_TYPE_C500 = "1005" 
-- 1000 颗蓝钻 1000 元钱
Res.STORE_DIAMON_TYPE_C1000 = "1006" 

------------------支付类型
Res.STORE_PAY_TYPE_ALIPAY = "3001"		--支付宝支付
Res.STORE_PAY_TYPE_WX = "3002"			--微信支付
Res.STORE_PAY_TYPE_APPSTORE = "3003"	--appStore支付
Res.STORE_PAY_TYPE_QIHU360 = "3008"		--360支付
Res.STORE_PAY_TYPE_ALIPAY_H5 = "3005"	-- 支付宝H5充值


---------------lua 调用 app 对应类型名称
-- lua 通知app升级版本
Res.lua_action_appupdate = "lua_action_appupdate"
-- lua 获取app版本号
Res.lua_action_app_version = "lua_action_app_version"
-- lua 微信登录
Res.lua_action_login_wx = "lua_action_login_wx"
-- lua qq登录
Res.lua_action_login_qq = "lua_action_login_qq"
-- lua android 奇虎360登录
Res.lua_action_login_qihu360 = "lua_action_login_qihu360"
-- lua  分享
Res.lua_action_share = "lua_action_share"
-- lua  获取jpush registerid
Res.lua_action_jpush_rgid = "lua_action_jpush_rgid"
-- lua  设置jpush 别名
Res.lua_action_jpush_alias = "lua_action_jpush_alias"
-- lua  设置jpush
Res.lua_action_jpush_tags = "lua_action_jpush_tags"
-- lua 获取ios的url
Res.lua_action_jpush_iosurl = "lua_action_jpush_iosurl"
-- lua 清理掉ios图标上的小红点 
Res.lua_action_clear_badge = "lua_action_clear_badge"
-- lua 结束当前iap
Res.lua_action_finish_iap = "lua_action_finish_iap"
--live scene refresh delay time
Res.live_refresh_delay_time = 7
--default channel id for ios
Res.default_channel_id_ios = "10000"
--default channel id for android
Res.default_channel_id_android = "20000"
-- lua 获取二维码
Res.lua_qr_code = "lua_qr_code"
-- lua 获取本地路径
Res.lua_local_path = "lua_local_path"
-- lua 压缩本地图片
Res.lua_compress_image = "lua_compress_image"
-- lua 获取ios端网络情况
Res.lua_iphone_network_status = "lua_iphone_network_status"
-- 
Res.default_selection_odds_item = "-2"

-- ios充值引导
Res.ios_recharge_guid = "http://crazybet.choopaoo.com/iosGuide/"