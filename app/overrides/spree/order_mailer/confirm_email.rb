Deface::Override.new(
  virtual_path: 'spree/order_mailer/confirm_email',
  name: 'order_mailer confirm_email',
  replace: "table.header",
  text: %q{
      <%= render file: "/#{Dir.getwd }/public/vinsol_spree_themes/current/mailer/confirm_email" %>
  }
)
Deface::Override.new(
  virtual_path: 'spree/order_mailer/cancel_email',
  name: 'order_mailer cancel_email',
  replace: "table.header",
  text: %q{
      <%= render file: "/#{Dir.getwd }/public/vinsol_spree_themes/current/mailer/cancel_email" %>
  }
)
Deface::Override.new(
  virtual_path: 'spree/reimbursement_mailer/reimbursement_email',
  name: 'reimbursement_mailer reimbursement_email',
  replace: "table.header",
  text: %q{
      <%= render file: "/#{Dir.getwd }/public/vinsol_spree_themes/current/mailer/reimbursement_email" %>
  }
)
Deface::Override.new(
  virtual_path: 'spree/shipment_mailer/shipped_email',
  name: 'shipment_mailer confirm_email',
  replace: "table.header",
  text: %q{
      <%= render file: "/#{Dir.getwd }/public/vinsol_spree_themes/current/mailer/shipped_email" %>
  }
)