Spree::Order.class_eval do
  def deliver_order_confirmation_email
      Spree::OrderMailer.confirm_email(id).deliver_later
      Spree::OwnerMailer.neworder_email(id).deliver_later
      update_column(:confirmation_delivered, true)
  end
end