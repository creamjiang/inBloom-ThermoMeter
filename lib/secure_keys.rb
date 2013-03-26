class SecureKeys
	# example .credentials.yml file below
	# defaults: &defaults
	#   INBLOOM_KEY: your_key
	#   INBLOOM_SECRET: your_secret

	# development: &development
	#   <<: *defaults

	# integration:
	#   <<: *defaults

	# production:
	#   <<: *defaults
	#
	unless defined?(CREDENTIAL_CONFIG)
		CREDENTIAL_CONFIG = {}
		config_file = Rails.root.join('.credentials.yml')
		if File.exist?(config_file)
			my_yml = YAML.load_file(config_file)
			CREDENTIAL_CONFIG.merge!(my_yml[Rails.env])
		end
	end
	
	def self.read(key)
		CREDENTIAL_CONFIG[key].present? ? CREDENTIAL_CONFIG[key] : ENV[key]
	end
end