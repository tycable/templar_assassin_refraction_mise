catapult_attack_lua=class({})
LinkLuaModifier( "modifier_catapult_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_catapult_attack_absorb", LUA_MODIFIER_MOTION_NONE )

function catapult_attack_lua:OnSpellStart( )
	self.bonus_damage=self:GetSpecialValueFor("bonus_damage")
	self.duration=self:GetSpecialValueFor("duration")

	EmitSoundOn( "Hero_TemplarAssassin.Refraction", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_catapult_attack", { duration = self.duration } )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_catapult_attack_absorb", { duration = self.duration } )

end