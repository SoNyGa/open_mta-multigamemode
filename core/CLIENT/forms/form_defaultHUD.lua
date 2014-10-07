form_defaultHUD = {}

function form_defaultHUD:create ()
	self.skin = maskShader:create("gamemodes/lobby/FILES/images/account/default.jpg", "core/FILES/shader/mask/mask_round.png")
	
	setPlayerHudComponentVisible("all", false)
	showChat(false)
	
	self.renderTarget = dxCreateRenderTarget(305*px, 120*py, true)
		
	self.renderFunc = function () self:render() end
	addEventHandler("onClientRender", root, self.renderFunc)
end

function form_defaultHUD:render ()
	localPlayer.level = localPlayer.level or 13
	localPlayer.currEXP = localPlayer.currEXP or 23144
	localPlayer.nextlvlEXP = localPlayer.nextlvlEXP or 54345
	localPlayer.percentEXP = localPlayer.percentEXP or (localPlayer.nextlvlEXP / localPlayer.currEXP) * 100

	if fileExists(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer))) then
		self.skin:update(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer)), false)
	else
		self.skin:update("gamemodes/lobby/FILES/images/account/default.jpg", false)
	end
	
	--dxSetRenderTarget(self.renderTarget, true)
		--dxSetBlendMode("modulate_add")
	
		self.skin:render(20*px, 20*px, 100*px, 100*px)
		dxDrawText(getMainTime(), 124*px, 20*py, 196*px, 47*py, tocolor(255, 255, 255, 255), 2.00*px, "sans", "left", "top", false, false, false, false, false)
		dxDrawLine(124*px, 47*py, 305*px, 47*py, tocolor(255, 255, 255, 255), 1*py, false)
		if DEBUG then
			dxDrawText(("%s ( %sms )"):format(localPlayer.name, localPlayer.ping), 196*px, 29*py, 306*px, 47*py, tocolor(255, 255, 255, 255), 1.00*py, "sans", "left", "center", true, false, false, false, false)
		else
			dxDrawText(("%s"):format(localPlayer.name), 196*px, 29*py, 306*px, 47*py, tocolor(255, 255, 255, 255), 1.00*py, "sans", "left", "center", true, false, false, false, false)
		end
		dxDrawRectangle(124*px, 66*py, 182*px, 14*py, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(124*px, 66*py, ((182 / localPlayer.percentEXP) * 100)*px, 14*py, tocolor(254, 138, 0, 189), false)
		dxDrawText(("Level: %s"):format(localPlayer.level), 124*px, 52*py, 306*px, 66*py, tocolor(255, 255, 255, 255), 1.00*py, "sans", "left", "bottom", true, false, false, false, false)
		dxDrawText(("%s $"):format(convertNumber(localPlayer.money)), 124*px, 52*py, 306*px, 66*py, tocolor(255, 255, 255, 255), 1.00*py, "default-bold", "right", "bottom", true, false, false, false, false)
		dxDrawText(("%s / %s EXP"):format(localPlayer.currEXP, localPlayer.nextlvlEXP), 124*px, 66*py, 306*px, 80*py, tocolor(255, 254, 254, 255), 0.80*py, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("", 124*px, 80*py, 306*px, 94*py, tocolor(255, 254, 254, 255), 0.80*py, "default-bold", "center", "center", false, false, false, false, false) -- "+ 3999 EXP"
		dxDrawRectangle(124*px, 84*py, 182*px, 14*py, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(124*px, 84*py, ((182 * localPlayer.health) / 100)*px, 14*py, (localPlayer.health > 20 and tocolor(0, 125, 0, 189) or tocolor(125, 0, 0, 255)), false)
		dxDrawRectangle(124*px, 84*py, ((182 * localPlayer.armor) / 100)*px, 14*py, tocolor(0, 0, 125, 189), false)
		dxDrawText(("%s %s"):format(math.round(localPlayer.health), "%"), 124*px, 84*py, 306*py, 98*py, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		--dxDrawRectangle(124, 102, 182, 14, tocolor(0, 0, 0, 137), false)
		--dxDrawRectangle(124, 102, (182 * localPlayer.armor) / 100, 14, tocolor(0, 36, 96, 189), false)
		--dxDrawText(("%s %s"):format(localPlayer.armor, "%"), 124, 102, 306, 116, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
	
		--dxSetBlendMode("blend")
	--dxSetRenderTarget()
	
	--dxDrawImage(0, 0, 305*px, 120*py, self.renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))
end

function form_defaultHUD:destroy ()
	self.skin:destroy()
	
	setPlayerHudComponentVisible("all", true)
	showChat(true)
	
	removeEventHandler("onClientRender", root, self.renderFunc)
end

form_defaultHUD:create()