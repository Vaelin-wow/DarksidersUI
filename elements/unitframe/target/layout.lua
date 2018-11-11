

	local _, ns = ...

	local FONT_BOLD = ns.FONT_BOLD

	local function round(number, decimals)
		return (("%%.%df"):format(decimals)):format(number)
	end

	ns.UnitSpecific.target = function(self, ...)
		ns.SharedLayout(self, ...)

		self:SetFrameLevel(0)	-- for layering
		self:SetSize(212, 60)

		local Health, Power, Castbar, RaidIcon, Border = self.Health, self.Power, self.Castbar, self.RaidTargetIndicator, {}

		Health:SetStatusBarTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Health-Target]]
		Health:SetHeight(32)
		Health:SetFrameLevel(2)
		Health:SetFrameStrata'BACKGROUND'
		Health:SetReverseFill(true)

		local HealthPoints = Health:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		HealthPoints:SetPoint('CENTER', Health, 'CENTER', 0, 0)
		HealthPoints:SetJustifyH'RIGHT'
		HealthPoints:SetFont(GameFontNormal:GetFont(), 10)
		HealthPoints:SetTextColor(1, 1, 1)

		self:Tag(HealthPoints, '[dksd:hp]')
		Health.value = HealthPoints

		local HealthPercent = Health:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		HealthPercent:SetPoint('LEFT', Health, 20, 0)
		HealthPercent:SetJustifyH'LEFT'
		HealthPercent:SetFont(GameFontNormal:GetFont(), 10)
		HealthPercent:SetTextColor(1, 1, 1)

		self:Tag(HealthPercent, '[dksd:perhp]')
		Health.percent = HealthPercent

		Power:SetFrameStrata'BACKGROUND'
		Power:SetReverseFill(true)
		Power:SetStatusBarTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Health-Target]]

		local PowerPoints = Power:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		PowerPoints:SetPoint('CENTER', Power, 'CENTER', 0, 0)
		PowerPoints:SetJustifyH'RIGHT'
		PowerPoints:SetFont(GameFontNormal:GetFont(), 10)
		PowerPoints:SetTextColor(1, 1, 1)

		self:Tag(PowerPoints, '[dksd:pp]')
		Power.value = PowerPoints

		local PowerPercent = Power:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		PowerPercent:SetPoint('LEFT', Power, 'LEFT', 21, 0)
		PowerPercent:SetJustifyH'RIGHT'
		PowerPercent:SetFont(GameFontNormal:GetFont(), 10)
		PowerPercent:SetTextColor(1, 1, 1)

		self:Tag(PowerPercent, '[dksd:perpp]')
		Power.percent = PowerPercent

		local Name = self:CreateFontString(nil, 'OVERLAY', 'dksdNameFont')
		-- local Name = self:CreateFontString(nil, 'OVERLAY')
		Name:SetPoint('TOPRIGHT', self, 'TOPRIGHT', 0, 26)
		Name:SetJustifyH'RIGHT'
		Name:SetWidth(212)
		Name:SetWordWrap(true)
		PowerPercent:SetFont(GameFontNormal:GetFont(), 8)
		self:Tag(Name, '[dksd:name]')


		local BG = self:CreateTexture(nil, 'MEDIUM', nil, 1)
		BG:SetSize(512, 256)
		BG:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\background]]
		BG:SetPoint('RIGHT', self, 120, -54)
		BG:SetTexCoord(1, 0, 0, 1)
		--
		local Portrait = self:CreateTexture(nil, 'MEDIUM', nil, 2)
		Portrait:SetSize(60, 60)
		Portrait:SetPoint('RIGHT', self, 72, 8)

		Portrait.Elite = self.Health:CreateTexture(nil, 'ARTWORK')
		Portrait.Elite:SetSize(100, 100)
		Portrait.Elite:SetPoint('RIGHT', self, 104, -11)
		Portrait.Elite:Hide()


		-- ns.BD(Castbar)
		-- Castbar:SetFrameStrata'HIGH'
		-- Castbar:ClearAllPoints()
		-- Castbar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 10, 22)
		-- Castbar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -10, 22)
		-- Castbar:SetHeight(6)
		-- Castbar.timeToHold = .4

		-- Castbar.IconBD = CreateFrame('Frame', nil, Castbar)
		-- Castbar.IconBD:SetSize(22, 22)
		-- Castbar.IconBD:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMLEFT', -18, 0)
		-- Castbar.IconBD:SetFrameLevel(2)
		-- ns.BD(Castbar.IconBD)

		-- Castbar.Icon = Castbar.IconBD:CreateTexture(nil, 'OVERLAY', nil, 7)
		-- Castbar.Icon:SetAllPoints(Castbar.IconBD)
		-- Castbar.Icon:SetTexCoord(.1, .9, .1, .9)

		-- Castbar.Icon.Border = Castbar.IconBD:CreateTexture(nil, 'BACKGROUND', nil, -7)
		-- Castbar.Icon.Border:SetSize(45, 45)
		-- Castbar.Icon.Border:SetPoint('TOP', Castbar.Icon, 0, 14)
		-- Castbar.Icon.Border:SetTexture[[Interface\Transmogrify\Textures]]
		-- Castbar.Icon.Border:SetTexCoord(.5, 1, .12, .25)

		-- Castbar.text = Castbar:CreateFontString(nil, 'ARTWORK')
		-- Castbar.text:SetPoint('BOTTOM', Castbar, 'TOP', 0, 12)
		-- Castbar.text:SetFont([[Fonts\ARIALN.ttf]], 11)
		-- Castbar.text:SetWidth(80)
		-- Castbar.text:SetJustifyH'CENTER'
		-- --Castbar.text:SetWordWrap(true)
		-- Castbar.text:SetShadowOffset(1, -1)
		-- Castbar.text:SetShadowColor(0, 0, 0, 1)

		-- Castbar.left = Castbar:CreateTexture(nil, 'BACKGROUND', nil, -1)
		-- Castbar.left:SetPoint('TOPLEFT', -5, 5)
		-- Castbar.left:SetPoint('BOTTOMRIGHT', 5, -5)
		-- Castbar.left:SetTexture[[Interface\ACHIEVEMENTFRAME/UI-ACHIEVEMENT-ACHIEVEMENTBACKGROUND]]
		-- Castbar.left:SetTexCoord(0, 1, .5, 1)
		-- Castbar.left:SetVertexColor(.7, .6, .5)

		-- Castbar.shadow = Castbar:CreateTexture(nil, 'BACKGROUND', nil, -3)
		-- Castbar.shadow:SetPoint('TOPLEFT', Castbar,  -12, 9)
		-- Castbar.shadow:SetPoint('BOTTOMRIGHT', Castbar,  12, -7)
		-- Castbar.shadow:SetTexture[[Interface\Scenarios\ScenarioParts]]
		-- Castbar.shadow:SetVertexColor(0, 0, 0, 1)
		-- Castbar.shadow:SetTexCoord(0, .641, 0, .18)

		
		Castbar:SetFrameStrata'HIGH'
		
		Castbar:SetStatusBarTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Health-Target]]
		ns.CLASS_COLOUR(Castbar)
		Castbar:ClearAllPoints()
		Castbar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 40, 20)
		-- Castbar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -10, 22)
		-- Castbar:SetPoint('BOTTOM', UIParent, 0, 305)
		Castbar:SetSize(159, 5)
		Castbar.timeToHold = .4
		
		Castbar.bg = Castbar:CreateTexture(nil, 'BACKGROUND')
		Castbar.bg:SetAllPoints(Castbar)
		-- Castbar:SetSize(128, 4)
		Castbar.bg:SetColorTexture(13/255,13/255,13/255)

		Castbar.fg = Castbar:CreateTexture(nil, 'OVERLAY')
		Castbar.fg:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Castbar_fg_target]]
		Castbar.fg:SetPoint('TOPLEFT', Castbar, -14, 4)
		Castbar.fg:SetSize(253, 16)

		Castbar.SafeZone = Castbar:CreateTexture(nil, 'ARTWORK')

		Castbar.IconBD = CreateFrame('Frame', nil, Castbar)
		Castbar.IconBD:SetSize(16,16)
		Castbar.IconBD:SetPoint('CENTER', Castbar, 'TOPLEFT', -28, -2)
		Castbar.IconBD:SetFrameLevel(2)
		-- ns.BD(Castbar.IconBD)

		local mask = Castbar:CreateMaskTexture()
		mask:SetTexture[[Interface\AddOns\DarksidersUI\art\misc\IconMask]]
		mask:SetAllPoints(Castbar.IconBD)
		-- mask:SetSize(50,50)

		Castbar.Icon = Castbar:CreateTexture(nil, 'OVERLAY', nil, 6)
		Castbar.Icon:SetAllPoints(Castbar.IconBD)
		Castbar.Icon:SetTexCoord(.1, .9, .1, .9)
		Castbar.Icon:AddMaskTexture(mask)

		Castbar.IconBorder = Castbar:CreateTexture(nil, 'OVERLAY', nil, 7)
		Castbar.IconBorder:SetPoint('TOPLEFT', Castbar.Icon, 'TOPLEFT', -2, 2)
		-- Castbar.IconBorder:SetAllPoints(Castbar.Icon)
		Castbar.IconBorder:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Castbar_icon__border]]
		Castbar.IconBorder:SetSize(20,20)

		Castbar.text = Castbar:CreateFontString(nil, 'OVERLAY', nill, 7)
		Castbar.text:SetPoint('BOTTOM', Castbar, 'TOP', 0, -8)
		Castbar.text:SetFont([[Fonts\ARIALN.ttf]], 11)
		Castbar.text:SetWidth(140)
		Castbar.text:SetJustifyH'CENTER'
		--Castbar.text:SetWordWrap(true)
		Castbar.text:SetShadowOffset(1, -1)
		Castbar.text:SetShadowColor(0, 0, 0, 1)

		-- Castbar.Incantation = CreateFrame('Frame', nil, Castbar)
		-- Castbar.Incantation:SetSize(68,68)
		-- Castbar.Incantation:SetPoint('CENTER', Castbar.IconBD, 'CENTER', 0, 0)

		-- Castbar.Incantation.t = Castbar.Incantation:CreateTexture(nil, 'OVERLAY', nil, 7)
		-- Castbar.Incantation.t:SetPoint('CENTER', 0, 0)
		-- Castbar.Incantation.t:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Castbar_icon__incantation]]
		-- Castbar.Incantation.t:SetSize(68,68)


		self.LvLParent = CreateFrame('Frame', nil, self)
		self.LvLParent:SetSize(32, 32)
		self.LvLParent:SetPoint('CENTER', Portrait, 'BOTTOMRIGHT', 15, -15)
		self.LvLParent:SetFrameStrata'MEDIUM'
		self.LvLParent:SetFrameLevel(2)

		local Level = self.LvLParent:CreateFontString(nil, 'OVERLAY', 'GameFontNormal', 7)
		Level:SetFont(STANDARD_TEXT_FONT, 10)
		Level:SetPoint('CENTER', self.LvLParent, "CENTER", 2, 1)
		Level:SetJustifyH'CENTER'
		self:Tag(Level, '[dksd:level]')

		Level.ring = self.LvLParent:CreateTexture(nil, 'OVERLAY', nil)
		Level.ring:SetSize(32, 32)
		Level.ring:SetPoint('CENTER', self.LvLParent, 'BOTTOMLEFT', 16, 16)
		Level.ring:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\RingFrame]]
		Level.ring:SetTexCoord(0, 1, 0, 1)
		--
		-- Level.BD = self.LvLParent:CreateTexture(nil, 'OVERLAY', nil, 3)
		-- Level.BD:SetSize(36, 36)
		-- Level.BD:SetPoint('CENTER', Portrait, 'BOTTOMLEFT', 4, 5)
		-- Level.BD:SetTexture[[Interface\MINIMAP\UI-Minimap-Background]]

		local PvPIndicator = self.Health:CreateTexture(nil, 'OVERLAY', nil, 1)
	    PvPIndicator:SetSize(32, 32)
	    PvPIndicator:SetPoint('CENTER', Portrait, 'LEFT', 4, 20)

	    local Prestige = self.Health:CreateTexture(nil, 'OVERLAY')
	    Prestige:SetSize(38, 40)
	    Prestige:SetPoint('CENTER', PvPIndicator)

		PvPIndicator.Prestige = Prestige
		--
		local QuestIndicator = self:CreateTexture(nil, 'OVERLAY')
	    QuestIndicator:SetSize(36, 36)
	    QuestIndicator:SetPoint('CENTER', Portrait, 'RIGHT')

	    self.QuestIndicator = QuestIndicator
		--
		RaidIcon:ClearAllPoints()
		RaidIcon:SetPoint('RIGHT', Health, 'LEFT', 18, 35)

		ns.AddAuraElement(self, unit, {'BOTTOMRIGHT', self, 'TOPRIGHT', 0, 45}, 'TOPRIGHT', 'LEFT', 'UP', 20)

		-- register new elements
		self.Name 			= Name
		self.Portrait		= Portrait
		self.Level			= Level
		self.PvPIndicator 	= PvPIndicator
		local OnInspectReady = function(self)
			local itemSlots = { "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
	"Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot" }
			local sum = 0
			local itemLength = 0
			for i = 1, #itemSlots do
				slot = GetInventorySlotInfo(itemSlots[i])
				link = GetInventoryItemLink("target", slot)
				if link then
					itemName, itemLink, itemQuality, itemLevel, _, _, _, _, equipSlot = GetItemInfo(link)
					sum = sum + itemLevel
					-- print("["..itemLevel.."]".." "..itemName)
					itemLength = itemLength + 1
				end
			end
			-- print('SUM : '..sum)
			-- print("LENGTH :"..itemLength)
			
			if InspectFrame and InspectFrame:IsShown() then
				if not InspectFrame.customIlvl then 
					InspectFrame.customIlvl = true
					InspectFrame.ilvlText = InspectFrame:CreateFontString(nil, 'ARTWORK')
					InspectFrame.ilvlText:SetPoint('TOP', InspectFrame, 'TOP', 140, -35)
					InspectFrame.ilvlText:SetFont([[Fonts\ARIALN.ttf]], 20)
					-- InspectFrame.ilvlText:SetWidth(80)
					InspectFrame.ilvlText:SetJustifyH'CENTER'
					InspectFrame.ilvlText:SetShadowOffset(1, -1)
					InspectFrame.ilvlText:SetShadowColor(0, 0, 0, 1)
				end
				local _, class = UnitClass("target")
				-- print(class)
				local colour = RAID_CLASS_COLORS[class]
				-- print(colour.r)
				InspectFrame.ilvlText:SetTextColor(colour.r, colour.g, colour.b)
				InspectFrame.ilvlText:SetText(round(sum / itemLength), 2)
			else 
				-- InspectFrame.ilvlText:SetText(sum / itemLength)
			end
		end
		self:RegisterEvent("INSPECT_READY", OnInspectReady);
		
	end

	

	--
