class InvoicesController < ApplicationController
  
  before_action :get_resource, except: [:index]
  before_action :get_resources, only: [:index]
  
  before_filter :authenticate_user!, except: [:pay, :update]
  
  def create
    @invoice.update_attributes params.require(:invoice).permit!
    if @invoice.save
      redirect_to @invoice
    else
      render :new
    end
  end
  
  def update

    if params[:stripeToken]
      
      if @invoice.pay! params[:stripeToken]
        flash[:succcess] = "Thank you for your payment!"
      else
        flash[:error] = "There was a problem processing your request. Please try again!"
      end
      
      redirect_to invoice_pay_path(@invoice)
      
    else
      if current_user
        if params[:invoice]
          @invoice.update_attributes params.require(:invoice).permit!
        end
        if @invoice.save
          redirect_to @invoice
        end
      end
    end
  end
  
  def pay
    
  end
  
  private
  
  def get_resource
    if params[:id] || params[:invoice_id]
      @invoice = Invoice.find(params[:id] || params[:invoice_id])
    else
      @invoice = Invoice.new
    end
  end
  
  def get_resources
    @invoices = Invoice.all
  end
  
end
