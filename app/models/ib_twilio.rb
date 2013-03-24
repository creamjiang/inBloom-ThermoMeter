class IbTwilio
  require 'twilio-ruby'
  
  # Twilio authentication credentials
  @account_sid = 'ACbb77fa10648add67ee8bd6a64ae03b8c'
  @auth_token = '681098b61c3ebb38b582c8559fee9fd4'

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # Twilio inbound phone number or this account
  TWILIO_PHONE = '+12028001589'
  
  def self.send(phone, text)
    begin
      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)


      @account = @client.account
      @message = @account.sms.messages.create({:from => '+12028001589', :to => phone, :body => text})
      puts @message
    rescue StandardError => bang
      # return error message
      error = "Error #{bang}\n"
      return error
    end
    
    # success
    return nil
  end
  
end