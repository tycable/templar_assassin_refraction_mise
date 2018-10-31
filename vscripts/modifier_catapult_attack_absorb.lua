modifier_catapult_attack_absorb=class({})

function modifier_catapult_attack_absorb:DeclareFunctions()
	local funcs={
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK,
	}
	return funcs
end

function modifier_catapult_attack_absorb:GetModifierEvasion_Constant()
	if self.count==0 then
		self:GetCaster():RemoveModifierByName("modifier_catapult_attack_absorb")
	end
	if self.count<0 then
		return 0
	else
		return 100
	end
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

function modifier_catapult_attack_absorb:OnAttack(kv)
	if kv.target==self:GetCaster() then
		self:DecrementStackCount()
		self.count=self.count-1
	end
end