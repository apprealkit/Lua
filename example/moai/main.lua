--------------------
-- AppRealKit for Moai Example
--------------------
local APP_NAME = "<c:2CF>ark<c>moai<c:F52>demo"
STAGE_WIDTH = 800
STAGE_HEIGHT = 240
MOAISim.openWindow ( APP_NAME, STAGE_WIDTH, STAGE_HEIGHT )
aViewport = MOAIViewport.new ()
aViewport:setScale ( STAGE_WIDTH, STAGE_HEIGHT )
aViewport:setSize ( STAGE_WIDTH, STAGE_HEIGHT )
aMainLayer = MOAILayer2D.new ()
aMainLayer:setViewport ( aViewport )


-- a basic MOAI console
-- application fonts
asciiTextCodes  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
appFonts        = {}
appFonts["anonymous"] = {
	ttf        = 'anonymous.ttf', 
	textcodes  = asciiTextCodes, 
	font       = MOAIFont.new(),
	size       = 10, 
	dpi        = 163
}

for appIndex, appFont in pairs(appFonts) do
	if (appFont.font ~= nil) then
    	appFont.font:loadFromTTF(appFont.ttf, appFont.textcodes, appFont.size, appFont.dpi)
	else
    	print("Some error loading fonts..")
	end
end

-- a text console message
aConsoleMsg = ""
aConsole = MOAITextBox.new()
aConsole:setFont(appFonts["anonymous"].font)
aConsole:setTextSize(appFonts["anonymous"].size)
aConsole:setString(APP_NAME)
aConsole:setRect(-STAGE_WIDTH/2 + 40, -STAGE_HEIGHT/2, STAGE_WIDTH/2, STAGE_HEIGHT/2 - 40)
aConsole:setYFlip(true)

aMainLayer:insertProp(aConsole)


function clearTextConsoleMessage()
	aConsoleMsg = ""
	aConsole:setString(aConsoleMsg)
end
function appMessage(instr)

	aConsoleMsg = aConsoleMsg .. instr
	aConsole:setString(aConsoleMsg)
end


-- and now it is time for the camera:
aPartition = MOAIPartition.new ()
aPartition:insertProp ( aConsole )
aMainLayer:setPartition ( aPartition )

MOAISim.pushRenderPass ( aMainLayer )

appMessage(APP_NAME)

-- implementing our own milliseconds counter, since we don't have a native one
local ms = 0
local ms_counter = MOAITimer.new ()
ms_counter:setSpan ( 0.010 )
ms_counter:setMode(MOAITimer.LOOP)
ms_counter:setListener ( MOAITimer.EVENT_TIMER_END_SPAN, function()
					ms = ms + 10
			end, true )
ms_counter:start()
--

require("apprealkit")

--Connection information
local host, port = "192.168.10.102", 7777 --Change to api.apprealkit.com - 9092 (PRODUCTION)
local appID, appSecret = "080693ab-7123-4aee-b560-9f6a8a332a43", "VORAI5D6yz" --Change to your APP-ID and APP-SECRET
local bDebug = false
local iLoginID = "1234"
local iMemberID = "5678"

--complete dialog
local function onComplete(code)
	--nothing
end

--show diaglog
local function showMsg(title, msg)
	MOAIDialog.showDialog (title, msg, "Yes", "No", "Cancel", false, onComplete)
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
local timer = MOAITimer.new()
timer:setSpan(2)
timer:setMode(MOAITimer.LOOP)
timer:setListener(MOAITimer.EVENT_TIMER_END_SPAN, function()
				oBalancer:authenticate(iLoginID, function(sMessage, iCode)
					showMsg("authenticate", sMessage)
				end)		
			end, true )
timer:start()

--getUser
local timer1 = MOAITimer.new()
timer1:setSpan(2)
timer1:setMode(MOAITimer.LOOP)
timer1:setListener(MOAITimer.EVENT_TIMER_END_SPAN, function()
				oBalancer:getUser(iLoginID, function(sMessage, iCode)
					showMsg("getUser", sMessage)
				end)	
			end, true )
timer1:start()

--getListUser
local timer2 = MOAITimer.new()
timer2:setSpan(2)
timer2:setMode(MOAITimer.LOOP)
timer2:setListener(MOAITimer.EVENT_TIMER_END_SPAN, function()
				arrUserID = {iLoginID, iMemberID}
			    oBalancer:getListUser(arrUserID, function(sMessage, iCode)
					showMsg("getListUser", sMessage)
				end)
			end, true )
timer2:start()