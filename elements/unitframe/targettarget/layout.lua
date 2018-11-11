

	local _, ns = ...

	local FONT_BOLD = ns.FONT_BOLD

	ns.UnitSpecific.targettarget = function(self, ...)
		ns.SharedLayout(self, ...)

		self:SetFrameLevel(0)	-- for layering
		self:SetSize(60, 20)

		local Health, Power, Castbar, RaidIcon, Border = self.Health, self.Power, self.Castbar, self.RaidTargetIndicator, {}

		--
		Health:SetStatusBarTexture[[Interface\AddOns\DarksidersUI\art\unitframe\Health-Target]]
		Health:SetHeight(8)
		Health:SetFrameLevel(2)
		Health:SetFrameStrata'MEDIUM'
		Health:SetReverseFill(true)
		--
		-- local HealthPoints = Health:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		-- HealthPoints:SetPoint('CENTER', Health, 'CENTER', 0, 0)
		-- HealthPoints:SetJustifyH'RIGHT'
		-- HealthPoints:SetFont(GameFontNormal:GetFont(), 10)
		-- HealthPoints:SetTextColor(1, 1, 1)
		--
		-- self:Tag(HealthPoints, '[dksd:hp]')
		-- Health.value = HealthPoints

		local BG = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
		BG:SetSize(75, 26)
		BG:SetTexture[[Interface\AddOns\DarksidersUI\art\unitframe\tot_bg]]
		BG:SetPoint('RIGHT', self, 5, 2)

		local HealthPercent = Health:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		HealthPercent:SetPoint('CENTER', Health, 0, 0)
		HealthPercent:SetJustifyH'CENTER'
		HealthPercent:SetFont(GameFontNormal:GetFont(), 8)
		HealthPercent:SetTextColor(1, 1, 1)

		self:Tag(HealthPercent, '[dksd:perhp]')
		Health.percent = HealthPercent

		Power:SetHeight(2)
		Power:SetPoint('TOP', self.Health, 'BOTTOM', 0, 0)
		Power:SetReverseFill(true)
		Power:SetFrameStrata'LOW'

		local Name = self:CreateFontString(nil, 'OVERLAY', 'dksdNameFontSmall')
		-- local Name = self:CreateFontString(nil, 'OVERLAY')
		Name:SetPoint('TOPRIGHT', self, 'TOPRIGHT', 0, 16)
		Name:SetJustifyH'RIGHT'
		-- Name:SetWidth(212)
		Name:SetWordWrap(true)
		self:Tag(Name, '[dksd:shortname]')

		RaidIcon:ClearAllPoints()
		RaidIcon:SetPoint('RIGHT', Health, 'LEFT', -7, 0)

		-- register new elements
		self.Name 			= Name
	end


	--
