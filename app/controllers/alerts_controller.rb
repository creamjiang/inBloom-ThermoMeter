class AlertsController < ApplicationController
  def sendit
    name = params[:name] || 'John Smith'
    text = params[:text] || "#{name} is in danger of failing 8th Gr English for the year. Please contact Mrs. Kim ASAP to arrange a conference."
    phone = params[:phone] || '+12025551212'
    IbTwilio.send(phone, text)

    flash[:notice] = "Alert sent for #{name}."
    redirect_to :back and return
  end
end
