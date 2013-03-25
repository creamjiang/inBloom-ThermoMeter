Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slc, get_env('INBLOOM_KEY'), get_env('INBLOOM_SECRET'), :setup => lambda { |env| 
     env['omniauth.strategy'].options[:client_options].site = APP_CONFIG['InbloomAPIUrl']
  }
  raise "InBloom Sandbox Key, Secret, or API url missing" unless get_env('INBLOOM_KEY') && get_env('INBLOOM_SECRET') && APP_CONFIG['InbloomAPIUrl']
end

# override default behavior - bit of monkey patch to allow testing in localhost
module OmniAuth
  class FailureEndpoint
    attr_reader :env

    def call
      #raise_out! if ENV['RACK_ENV'].to_s == 'development'
      redirect_to_failure
    end
  end
end

private 

def get_env(key)
	CREDENTIAL_CONFIG[key].present? ? CREDENTIAL_CONFIG[key] : ENV[key]
end
