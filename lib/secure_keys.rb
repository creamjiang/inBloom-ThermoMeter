class SecureKeys
	def self.read(key)
		CREDENTIAL_CONFIG[key].present? ? CREDENTIAL_CONFIG[key] : ENV[key]
	end
end