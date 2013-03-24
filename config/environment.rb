# Load the rails application
require File.expand_path('../application', __FILE__)

# load config
app_config_file = Rails.root.join('config/config.yml')
CONFIG_YML = YAML.load_file(app_config_file)
APP_CONFIG = CONFIG_YML[Rails.env]

# load credentials if present - you may want to put these for production config outside of git
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
CREDENTIAL_CONFIG = {}
credential_config = Rails.root.join('.credentials.yml')
if File.exist?(credential_config)
	my_yml = YAML.load_file(credential_config)
	CREDENTIAL_CONFIG.merge!(my_yml[Rails.env])
end

# Initialize the rails application
SlcSample2::Application.initialize!
