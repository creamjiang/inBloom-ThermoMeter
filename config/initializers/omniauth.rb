unless APP_CONFIG['mock_in_bloom']
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :slc, get_env('INBLOOM_KEY'), get_env('INBLOOM_SECRET'), :setup => lambda { |env|
      env['omniauth.strategy'].options[:client_options].site = 'https://api.sandbox.slcedu.org'
    }
    raise "InBloom Sandbox Key or Secret missing" unless get_env('INBLOOM_KEY') && get_env('INBLOOM_SECRET')
  end
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
