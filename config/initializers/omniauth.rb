require 'secure_keys'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slc, SecureKeys.read('INBLOOM_KEY'), SecureKeys.read('INBLOOM_SECRET'), :setup => lambda { |env| 
     env['omniauth.strategy'].options[:client_options].site = APP_CONFIG['InbloomAPIUrl']
  }
  raise "InBloom Sandbox Key, Secret, or API url missing" unless SecureKeys.read('INBLOOM_KEY') && SecureKeys.read('INBLOOM_SECRET') && APP_CONFIG['InbloomAPIUrl']
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

