Spree::Admin::OrdersController.class_eval do
    before_action :load_order,only: [:edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart, :store, :set_store,:summary]
    
    respond_to :html
    
    def cancel
        event = "void"
        event = 'void_transaction' if event == 'void'
        update_payment(event,"cancel")
        
        @order.canceled_by(try_spree_current_user)
        flash[:success] = Spree.t(:order_canceled)
        redirect_back fallback_location: spree.edit_admin_order_url(@order)
    end
    
    def approve
        event = "capture"
        event = 'void_transaction' if event == 'void'
        update_payment(event,"approve")
        
        @order.approved_by(try_spree_current_user)
        flash[:success] = Spree.t(:order_approved)
        redirect_back fallback_location: spree.edit_admin_order_url(@order)
    end
      
    def summary
        @payments = @order.payments.includes(refunds: :reason)
        @refunds = @payments.flat_map(&:refunds)
        @state_changes = @order.state_changes.includes(:user).order(created_at: :desc)
    end
    
    def destroy
        #@order = Spree::Order.find(params[:id])
        @order = Spree::Order.find_by!(number: params[:id])
        bill_address_id = @order.bill_address_id
        ship_address_id =  @order.ship_address_id
        begin
          # TODO: why is @product.destroy raising ActiveRecord::RecordNotDestroyed instead of failing with false result
          if @order.destroy
            destroy_spree_address_related_order(bill_address_id,ship_address_id);
            flash[:success] = Spree.t('notice_messages.order_deleted')
          else
            flash[:error] = Spree.t('notice_messages.order_not_deleted', error: @order.errors.full_messages.to_sentence)
          end
        rescue ActiveRecord::RecordNotDestroyed => e
          flash[:error] = Spree.t('notice_messages.order_not_deleted', error: e.message)
        end

        redirect_to admin_orders_path
     end
     private
     def update_payment (event,type)
        @order.payments.each do |payment|
          begin 
            if payment.send("#{event}!")
              flash[:success] = Spree.t(:order_payment_updated,text: Spree.t(type))
            else
              flash[:error] = Spree.t(:cannot_perform_operation)
            end
          end  
        end  
     end   
     def destroy_spree_address_related_order(bill_address_id,ship_address_id)
        begin
          bill_address_users = Spree::User.find_by(bill_address_id: bill_address_id)
          ship_address_users = Spree::User.find_by(ship_address_id: ship_address_id)
          
          if bill_address_users.nil? && ship_address_users.nil?
            #delete bill_address_id
            begin
              baddress = Spree::Address.find(bill_address_id)
              if !baddress.nil?
                  baddress.destroy
              end  
            end
            
            #delete ship_address_id
            begin
              saddress = Spree::Address.find(ship_address_id)
              if !saddress.nil?
                  saddress.destroy
              end 
            end
          end  
        end    
     end 
     
end