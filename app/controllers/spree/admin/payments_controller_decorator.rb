Spree::Admin::PaymentsController.class_eval do
    #change success redirect
      def fire
        return unless event = params[:e] and @payment.payment_source

        # Because we have a transition method also called void, we do this to avoid conflicts.
        event = 'void_transaction' if event == 'void'
        if @payment.send("#{event}!")
          flash[:success] = Spree.t(:payment_updated)
        else
          flash[:error] = Spree.t(:cannot_perform_operation)
        end
      rescue Spree::Core::GatewayError => ge
        flash[:error] = ge.message.to_s
      ensure
        redirect_to summary_admin_order_path(@order)
      end
      
end