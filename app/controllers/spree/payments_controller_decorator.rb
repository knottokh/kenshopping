Spree::PaymentsController.class_eval do
    def update
      if params.has_key?(:payment)
        unless @payment.order.payment_state == "paid" 
          if @payment.order.payments.from_bank_transfer.first.bank_attachment_file_name.nil?
              Spree::OwnerMailer.payment_email(@payment.order.id).deliver_later  
          end  
          payment_details = Spree::PaymentDetails.new(@payment, payment_params)
          if payment_details.save
            flash[:notice] = Spree.t(:payment_successfully_updated)
          else
            flash[:error] = payment_details.errors.to_sentence
          end
        end  
        #redirect_to :back
        redirect_back fallback_location: root_path
      end  
      
    end
end