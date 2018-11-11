
	local _, ns = ...

	DKSD_VAR = {
		['raid']  = {
			pets			= true, -- undecided
			name  			= true,
			maintankassist 	= true,
			power 			= true,
			role  			= true,
			value 			= true,
		},
	}

	local ADDON_LOADED = function(self, event, addon)
		if  iidCombatActionBar == nil then
			iidCombatActionBar = 1
		end
		if  iidRaidLayout == nil then
			iidRaidLayout = 1
		end
	end

	dksd:RegisterEvent('ADDON_LOADED', ADDON_LOADED)


	--