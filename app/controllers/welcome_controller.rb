class WelcomeController < ApplicationController
  
  def index
    if current_user
      redirect_to :invoices
    else
      redirect_to "http://madebyhd.us/"
    end
  end
  
end