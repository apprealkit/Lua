--------------------
-- AppRealKit for Love Example
--------------------
require("apprealkit")

--Connection information
local host, port = "192.168.10.102", 7777 --Change to api.apprealkit.com - 9092 (PRODUCTION)
local appID, appSecret = "080693ab-7123-4aee-b560-9f6a8a332a43", "VORAI5D6yz" --Change to your APP-ID and APP-SECRET
local bDebug = false
local iLoginID = "1234"
local iMemberID = "5678"
local sResponse = ""

--Get balancer instance
oBalancer = AppRealKit.Realtime.Balancer:getInstance()

--Set production data
oBalancer:setProductID(appID, appSecret)

--Set opened callback
oBalancer:onKitOpen(function(sMessage, iCode)
	sResponse = sMessage
end)

--Set received callback
oBalancer:onKitMessage(function(sMessage, iCode)
	sResponse = sMessage
end)

--Connection information
oBalancer:connect(host, port)

-- making sure to give some CPU time to ARK
function love.update(dt)
   oBalancer:enterFrame() --It is very important
end

--Draw interface
function love.draw()
    love.graphics.print(sResponse, 200, 300)
end

--Authenticate login ID
oBalancer:authenticate(iLoginID, function(sMessage, iCode)
	sResponse = sMessage
end)

--getUser
oBalancer:getUser(iLoginID, function(sMessage, iCode)
	sResponse = sMessage
end)

--getListUser
arrUserID = {iLoginID, iMemberID}
oBalancer:getListUser(arrUserID, function(sMessage, iCode)
	sResponse = sMessage
end)