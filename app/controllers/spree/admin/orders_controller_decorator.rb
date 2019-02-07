Spree::Admin::OrdersController.class_eval do
    before_action :load_order,only: [:edit, :update, :cancel, :resume, :approve, :resend, :open_adjustments, :close_adjustments, :cart, :store, :set_store,:summary]
    
    respond_to :html
    
    def summary
        @payments = @order.payments.includes(refunds: :reason)
        @refunds = @payments.flat_map(&:refunds)
        @state_changes = @order.state_changes.includes(:user).order(created_at: :desc)
    end
end