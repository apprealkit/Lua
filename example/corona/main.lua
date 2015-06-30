--------------------
-- AppRealKit for Corona Example
--------------------
require("apprealkit")

--Connection information
local host, port = "192.168.10.102", 7777 --Change to api.apprealkit.com - 9092 (PRODUCTION)
local appID, appSecret = "080693ab-7123-4aee-b560-9f6a8a332a43", "VORAI5D6yz" --Change to your APP-ID and APP-SECRET
local bDebug = false
local iLoginID = "1234"
local iMemberID = "5678"

--complete dialog
local function onComplete(event)
	--Nothing
end

--show diaglog
local function showMsg(title, msg)	
	native.showAlert(title, msg, { "OK", "No" }, onComplete)
end

--Get balancer instance
oBalancer = AppRealKit.Realtime.Balancer:getInstance()

--Set production data
oBalancer:setProductID(appID, appSecret)

--Set opened callback
oBalancer:onKitOpen(function(sMessage, iCode)
	showMsg("onKitOpen", sMessage)
end)

--Set received callback
oBalancer:onKitMessage(function(sMessage, iCode)
	showMsg("onKitMessage", sMessage)
end)

--Connection information
oBalancer:connect(host, port)

--Authenticate login ID
timer.performWithDelay(1000, function()
	oBalancer:authenticate(iLoginID, function(sMessage, iCode)
		showMsg("authenticate", sMessage)
	end)
end, 1)

--getUser
timer.performWithDelay(3000, function()
	oBalancer:getUser(iLoginID, function(sMessage, iCode)
		showMsg("getUser", sMessage)
	end)
end, 1)

--getListUser
timer.performWithDelay(5000, function()
	arrUserID = {iLoginID, iMemberID}
    oBalancer:getListUser(arrUserID, function(sMessage, iCode)
		showMsg("getListUser", sMessage)
	end)
end, 1)