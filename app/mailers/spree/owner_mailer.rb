module Spree
  class OwnerMailer < BaseMailer
    def neworder_email(order, resend = false)
      #Spree::Role     
      emailarr = Spree::User.includes(:spree_roles).where("spree_roles.name" => "manage").map {|i| i.email }.to_a
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.current.name} #{Spree.t('order_mailer.neworder_email.subject')} ##{@order.number}"
      mail(to: emailarr, from: from_address, subject: subject)
    end

    def payment_email(order, resend = false)
      emailarr = Spree::User.includes(:spree_roles).where("spree_roles.name" => "manage").map {|i| i.email }.to_a    
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.current.name} #{Spree.t('order_mailer.payment_email.subject')} ##{@order.number}"
      mail(to: @order.email, from: from_address, subject: subject)
    end
  end
end