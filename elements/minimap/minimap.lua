﻿

	local _, ns = ...

	local FONT_REGULAR 	= ns.FONT_REGULAR
	local FONT_BOLD		= ns.FONT_BOLD

	Minimap:SetSize(160, 160)
	-- Minimap:SetMaskTexture[[Interface\ChatFrame\ChatFrameBackground]]
	MinimapCluster:ClearAllPoints()
	Minimap:SetFrameLevel(15)
	MinimapCluster:SetPoint('BOTTOMRIGHT', -15, 0)
	-- Minimap.ring = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -1)
	-- Minimap.ring:SetPoint('TOPLEFT', Minimap, -24, 24)
	-- Minimap.ring:SetPoint('BOTTOMRIGHT', Minimap, 24, -24)
	-- Minimap.ring:SetTexture[[Interface\Artifacts\Artifacts-PerkRing-Final-Mask]]
	-- Minimap.ring:SetVertexColor(.9, .9, .9)

	Minimap.bg = Minimap:CreateTexture(nil, 'OVERLAY', nil, -2)
	Minimap.bg:SetSize(160,160)
	Minimap.bg:SetPoint('TOPLEFT', Minimap, -6, 6)
	Minimap.bg:SetPoint('BOTTOMRIGHT', Minimap, 6, -6)
	Minimap.bg:SetTexture[[Interface\AddOns\DarksidersUI\art\map\mmap_def]]
	

	-- Minimap.border = Minimap:CreateTexture(nil, 'BACKGROUND', nil, 0)
	-- Minimap.border:SetSize(152, 152)
	-- Minimap.border:SetPoint('CENTER', Minimap, -6, -18)
	-- Minimap.border:SetTexture[[Interface\Minimap\UI-Minimap-Border]]
	-- Minimap.border:SetTexCoord(.25, 1, .125, .875)
	-- Minimap.border:SetVertexColor(1, .8, 0)

	-- Minimap.prestige = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -3)
	-- Minimap.prestige:SetSize(140, 70)
	-- Minimap.prestige:SetPoint('BOTTOM', Minimap, 0, -25)
	-- Minimap.prestige:SetTexture[[Interface\PVPFrame\TitlePrestige]]
	-- Minimap.prestige:SetTexCoord(.565, .82, .35, .465)
	-- Minimap.prestige:SetVertexColor(.9, .9, .9)

	Minimap.compass = Minimap:CreateTexture(nil, 'OVERLAY', nil, 1)
	Minimap.compass:SetSize(285, 285)
	Minimap.compass:SetPoint'CENTER'
	Minimap.compass:SetTexture[[Interface\Minimap\CompassRing]]

	local f = CreateFrame('Frame', nil, UIParent)
	f:SetFrameLevel(3)
	f:SetFrameStrata'HIGH'
	f:SetSize(200, 50)
	f:SetPoint('TOP', Minimap, 8, 55)

	Minimap.banner = f:CreateTexture(nil, 'OVERLAY', nil, 4)
	Minimap.banner:SetAllPoints(f)
	Minimap.banner:SetTexture[[Interface\AddOns\DarksidersUI\art\map\banner]]
	-- Minimap.banner:SetTexCoord(.35, .725, .53, .46)

	--[[Minimap.top = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -1)
	Minimap.top:SetSize(150, 18)
	Minimap.top:SetPoint('TOP', Minimap, 0, 14)
	Minimap.top:SetTextureInterface\BlackMarket\_WoodFrame-TileHorizontal
	Minimap.top:SetTexCoord(0, 1, 0, .5)

	Minimap.bottom = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -1)
	Minimap.bottom:SetSize(150, 18)
	Minimap.bottom:SetPoint('BOTTOM', Minimap, 0, -17)
	Minimap.bottom:SetTextureInterface\BlackMarket\_WoodFrame-TileHorizontal
	Minimap.bottom:SetTexCoord(0, 1, .5, 1)

	Minimap.left = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -1)
	Minimap.left:SetSize(16, 140)
	Minimap.left:SetPoint('LEFT', Minimap, -14, 0)
	Minimap.left:SetTextureInterface\BlackMarket\!WoodFrame-TileVertical
	Minimap.left:SetTexCoord(0, .46, 0, 1)

	Minimap.right = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -1)
	Minimap.right:SetSize(16, 140)
	Minimap.right:SetPoint('RIGHT', Minimap, 16, 2)
	Minimap.right:SetTextureInterface\BlackMarket\!WoodFrame-TileVertical
	Minimap.right:SetTexCoord(.5, 1, 0, 1)

	Minimap.bg = Minimap:CreateTexture(nil, 'BACKGROUND', nil, -2)
	Minimap.bg:SetPoint('TOPLEFT', -16, 16)
	Minimap.bg:SetPoint('BOTTOMRIGHT', 16, -16)
	Minimap.bg:SetColorTexture(0, 0, 0)]]

	-- Minimap.banner = Minimap:CreateTexture(nil, 'OVERLAY')
	-- Minimap.banner:SetSize(120, 48)
	-- Minimap.banner:SetPoint('TOP', Minimap.bottom)
	-- Minimap.banner:SetTextureInterface\BlackMarket\BlackMarketSign
	-- Minimap.banner:SetVertexColor(.6, .6, .6)

	MinimapZoneTextButton:SetFrameLevel(16)
	MinimapZoneTextButton:ClearAllPoints()
	MinimapZoneTextButton:SetPoint('TOP', Minimap, 0, 27)
	MinimapZoneTextButton:SetWidth(160)

	MinimapZoneText:SetParent(f)
	MinimapZoneText:SetFont(FONT_BOLD, 12)
	MinimapZoneText:SetDrawLayer('OVERLAY', 7)
	-- MinimapZoneText:SetShadowOffset(0, 0)

	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetArchBlobRingAlpha(0)
	Minimap:SetQuestBlobRingScalar(0)
	Minimap:SetQuestBlobRingAlpha(0)

	for _, v in pairs(
		{
		MinimapBorder, 	MinimapBorderTop, 	MinimapBackdrop,
		MinimapZoomIn, 	MinimapZoomOut,		MiniMapVoiceChatFrame,
		GameTimeFrame,	MiniMapTracking,	MinimapNorthTag,
		}
	) do
		v:Hide()
	end

	local MapTextUpdate = function(self, event)
		MinimapZoneText:SetTextColor(1,1,1,0.75)
		if  MinimapZoneText:GetStringWidth() > 100 then
			local t = GetMinimapZoneText():gsub('(%u)%S* %l*%s*', '%1. ')
			MinimapZoneText:SetText(t)
			if  MinimapZoneText:GetStringWidth() > 90 then	-- repeat!
				t =   GetMinimapZoneText():gsub('(%a)([%w_\']*)', '%1.')
				MinimapZoneText:SetText(t)
			end
		end
	end

	local HighLightOrderHall = function (self, event)
		print('highlight')
	end

	Minimap:SetScript('OnMouseUp', function(self, button)
		Minimap:StopMovingOrSizing()
	    if button == 'RightButton' then
	        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * .7), -3)
	    elseif button == 'MiddleButton' then
	        ToggleCalendar()
	    else
	        Minimap_OnClick(self)
	    end
	end)

	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('OnMouseWheel', function(self, arg1)
		if arg1 > 0 then Minimap_ZoomIn() else Minimap_ZoomOut() end
	end)

	Minimap:HookScript('OnEvent',	MapTextUpdate)

	dksd:RegisterEvent('ZONE_CHANGED', 			MapTextUpdate)
	dksd:RegisterEvent('ZONE_CHANGED_INDOORS',	MapTextUpdate)
	dksd:RegisterEvent('ZONE_CHANGED_NEW_AREA',	MapTextUpdate)
	dksd:RegisterEvent('PLAYER_REGEN_ENABLED',	MapTextUpdate)

	-- hooksecurefunc('GarrisonMinimapBuilding_ShowPulse',   HighLightOrderHall)
	-- GarrisonLandingPageMinimapButton:RegisterEvent('GARRISON_BUILDING_ACTIVATABLE', function(self, ...)
	-- 	local buildingName, garrisonType = ...;
	-- 	print('NEW MISSION')
	-- 	print(buildingName)
	-- end)
	-- GarrisonLandingPageMinimapButton:RegisterEvent('GARRISON_SHOW_LANDING_PAGE', function(self, event, ...)
	-- 	print('test')
	-- 	-- local buildingName, garrisonType = ...;
	-- 	-- print('NEW MISSION')
	-- 	-- print(buildingName)
	-- end)


	--
