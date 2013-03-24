class IbTwilio
  require 'secure_keys'
  require 'twilio-ruby'
  
  # Twilio authentication credentials
  @account_sid = SecureKeys.read('TWILIO_SID')
  @auth_token = SecureKeys.read('TWILIO_TOKEN')

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # Twilio inbound phone number or this account
  TWILIO_PHONE = '+12028001589'

  # Twilio verified phones
  EVAL_PHONES = SecureKeys.read('TWILIO_PHONES')
  TWILIO_MODE = 'evaluation' # change this to something else if production
  
  def self.send(phone, text)
    begin
      # set up a client to talk to the Twilio REST API
      client = Twilio::REST::Client.new(@account_sid, @auth_token)

      # evaluation mode only send to verified phone numbers, comment this out when paid twilio account
      if TWILIO_MODE == 'evaluation' && EVAL_PHONES.present?
        phone = EVAL_PHONES.shuffle.first
      end

      account = client.account
      message = account.sms.messages.create({:from => TWILIO_PHONE, :to => phone, :body => text})
      puts @message
    rescue Exception => bang
      # return error message
      error = "Error #{bang}\n"
      return error
    end
    
    # success
    return nil
  end
  
end