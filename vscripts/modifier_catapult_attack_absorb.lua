modifier_catapult_attack_absorb=class({})

function modifier_catapult_attack_absorb:DeclareFunctions()
	local funcs={
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_catapult_attack_absorb:OnCreated(kv)
	self.count=5
	self:SetStackCount(5)

	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )	
		ParticleManager:SetParticleControlEnt(self.nFXIndex, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end

function modifier_catapult_attack_absorb:OnTakeDamage(kv)
	local caster=self:GetCaster()
	if kv.attacker~=caster then	
		self:DecrementStackCount()
		self.count=self.count-1
		caster:SetHealth(caster:GetHealth()+kv.damage)
	end

	if self.count==0 then
		self:GetCaster():RemoveModifierByName("modifier_catapult_attack_absorb")
	end
end