class Invoice
  
  include Mongoid::Document
  
  field :name
  field :invoice_id
  
  field :description
  field :amount
  
  field :invoicee_name
  field :invoicee_address
  
  field :status, default: "Unpaid"
  
  def pay! token
    # Create the charge on Stripe's servers - this will charge the user's card
#    begin
      charge = Stripe::Charge.create(
        :amount => self.amount.to_i * 100,
        :currency => "usd",
        :card => token,
        :description => self.description
      )
      
      self.status = "Paid"
      self.save!
      true
#    rescue
#      false
#    end    
  end
  
  def paid?
    status == "Paid"
  end
  
end