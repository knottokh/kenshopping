Spree::Admin::OrdersController.class_eval do
    before_action :load_order,only: [:edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart, :store, :set_store,:summary]
    
    respond_to :html
    
    def summary
        @payments = @order.payments.includes(refunds: :reason)
        @refunds = @payments.flat_map(&:refunds)
        @state_changes = @order.state_changes.includes(:user).order(created_at: :desc)
    end
    
    def destroy
        #@order = Spree::Order.find(params[:id])
        @order = Spree::Order.find_by!(number: params[:id])
        begin
          # TODO: why is @product.destroy raising ActiveRecord::RecordNotDestroyed instead of failing with false result
          if @order.destroy
            flash[:success] = Spree.t('notice_messages.order_deleted')
          else
            flash[:error] = Spree.t('notice_messages.order_not_deleted', error: @order.errors.full_messages.to_sentence)
          end
        rescue ActiveRecord::RecordNotDestroyed => e
          flash[:error] = Spree.t('notice_messages.order_not_deleted', error: e.message)
        end

        redirect_to admin_orders_path
     end
end