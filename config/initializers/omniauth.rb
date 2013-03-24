Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slc, get_env('INBLOOM_KEY'), get_env('INBLOOM_SECRET'), :setup => lambda { |env| 
     env['omniauth.strategy'].options[:client_options].site = 'https://api.sandbox.slcedu.org'
  }
  raise "InBloom Sandbox Key or Secret missing" unless get_env('INBLOOM_KEY') && get_env('INBLOOM_SECRET')
end

private 

def get_env(key)
	CREDENTIAL_CONFIG[key].present? ? CREDENTIAL_CONFIG[key] : ENV[key]
end
