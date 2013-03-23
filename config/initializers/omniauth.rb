Rails.application.config.middleware.use OmniAuth::Builder do
  
  if Rails.env.production?
    provider :slc, APP_CONFIG['inbloomKey'], APP_CONFIG['inbloomSecret']
  else
    provider :slc, APP_CONFIG['inbloomKey'], APP_CONFIG['inbloomSecret'], :setup => lambda{|env| 
       env['omniauth.strategy'].options[:client_options].site = 'https://api.sandbox.slcedu.org'
    }
  end

end