class AlertsController < ApplicationController
  def sendit
    name = params[:name] || 'John Smith'
    text = params[:text] || "Alert for #{name}"
    phone = params[:phone] || '+12025551212'
    IbTwilio.send(phone, text)

    flash[:notice] = "Alert sent for #{name}"
    redirect_to klasses_url && return
  end
end