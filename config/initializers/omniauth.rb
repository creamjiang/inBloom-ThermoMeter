Rails.application.config.middleware.use OmniAuth::Builder do
  
  if Rails.env.production?
    provider :slc, ENV['INBLOOM_KEY'], ENV['INBLOOM_SECRET']
  else
    provider :slc, ENV['INBLOOM_KEY'], ENV['INBLOOM_SECRET'], :setup => lambda{|env| 
       env['omniauth.strategy'].options[:client_options].site = 'https://api.sandbox.slcedu.org'
    }
  end

end
