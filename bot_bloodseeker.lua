-------------------------------------------------------------------------------
--- AUTHOR: Keithen
--- GITHUB REPO: https://github.com/Nostrademous/Dota2-FullOverwrite
-------------------------------------------------------------------------------

require( GetScriptDirectory().."/constants" )
require( GetScriptDirectory().."/item_purchase_bloodseeker" )
require ( GetScriptDirectory().."/ability_usage_bloodseeker" )
require( GetScriptDirectory().."/jungling_generic" )

local utils = require( GetScriptDirectory().."/utility" )
local dt = require( GetScriptDirectory().."/decision_tree" )

local BLOODSEEKER_SKILL_Q = "bloodseeker_bloodrage";
local BLOODSEEKER_SKILL_W = "bloodseeker_blood_bath";
local BLOODSEEKER_SKILL_E = "bloodseeker_thirst";
local BLOODSEEKER_SKILL_R = "bloodseeker_rupture";

local BLOODSEEKER_ABILITY1 = "special_bonus_armor_5"
local BLOODSEEKER_ABILITY2 = "special_bonus_attack_damage_25"
local BLOODSEEKER_ABILITY3 = "special_bonus_attack_speed_30"
local BLOODSEEKER_ABILITY4 = "special_bonus_hp_250"
local BLOODSEEKER_ABILITY5 = "special_bonus_respawn_reduction_30"
local BLOODSEEKER_ABILITY6 = "special_bonus_all_stats_10"
local BLOODSEEKER_ABILITY7 = "special_bonus_unique_bloodseeker"
local BLOODSEEKER_ABILITY8 = "special_bonus_lifesteal_30"

local BloodseekerAbilityPriority = {
	BLOODSEEKER_SKILL_Q,    BLOODSEEKER_SKILL_E,    BLOODSEEKER_SKILL_Q,    BLOODSEEKER_SKILL_W,    BLOODSEEKER_SKILL_Q,
    BLOODSEEKER_SKILL_R,    BLOODSEEKER_SKILL_E,    BLOODSEEKER_SKILL_E,    BLOODSEEKER_SKILL_W,    BLOODSEEKER_ABILITY2,
    BLOODSEEKER_SKILL_E,    BLOODSEEKER_SKILL_R,    BLOODSEEKER_SKILL_W,    BLOODSEEKER_SKILL_W,    BLOODSEEKER_ABILITY3,
    BLOODSEEKER_SKILL_E,    BLOODSEEKER_SKILL_R,    BLOODSEEKER_ABILITY5,   BLOODSEEKER_ABILITY8
};

local bloodseekerActionQueue = { [1] = constants.ACTION_NONE }

bloodseekerBot = dt:new()

function bloodseekerBot:new(o)
	o = o or dt:new(o)
	setmetatable(o, self)
	self.__index = self
	return o
end

bloodseekerBot = bloodseekerBot:new{prevTime = -999.0, actionQueue = bloodseekerActionQueue, abilityPriority = BloodseekerAbilityPriority}
--bloodseekerBot:printInfo();

bloodseekerBot.Init = false;

function bloodseekerBot:ConsiderAbilityUse()
	ability_usage_bloodseeker.AbilityUsageThink()
end

function Think()
    local npcBot = GetBot()

		bloodseekerBot:Think(npcBot)
end

function bloodseekerBot:DoRetreat(bot)
	return false -- we're fine
end
