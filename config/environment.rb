# Load the rails application
require File.expand_path('../application', __FILE__)

# load config
app_config_file = Rails.root.join('config/config.yml')
CONFIG_YML = YAML.load_file(app_config_file)
APP_CONFIG = CONFIG_YML[Rails.env]

# load credentials
CREDENTIAL_CONFIG = {}
credential_config = Rails.root.join('.credentials.yml')
if File.exist?(credential_config)
	my_yml = YAML.load_file(credential_config)
	CREDENTIAL_CONFIG.merge!(my_yml[Rails.env])
end
debugger

# Initialize the rails application
SlcSample2::Application.initialize!
