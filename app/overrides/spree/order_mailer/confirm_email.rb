Deface::Override.new(
  virtual_path: 'spree/order_mailer/confirm_email',
  name: 'order_mailer confirm_email',
  replace: "table.header",
  partial: 'spree/mail_template/confirm_email'
)