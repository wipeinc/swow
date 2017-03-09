# -- immutable: string

module Swow
	module Constants
		REGIONS = %w(us eu kr tw).to_set
		CHARACTER_FIELDS = %w(achievements appearance feed guild hunterPets items
												  mounts pets petSlots professions pvp quests reputation
												  statistics stats talents titles audit).to_set
		GUILD_FIELDS = %w(members acheivements new challenge).to_set
	end
end
