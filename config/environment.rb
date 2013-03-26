# Load the rails application
require File.expand_path('../application', __FILE__)

# load config
app_config_file = Rails.root.join('config/config.yml')
CONFIG_YML = YAML.load_file(app_config_file)
APP_CONFIG = CONFIG_YML[Rails.env]

# Initialize the rails application
SlcSample2::Application.initialize!
