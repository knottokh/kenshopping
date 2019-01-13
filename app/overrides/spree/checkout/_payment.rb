Deface::Override.new(
  virtual_path: 'spree/checkout/_payment',
  name: 'checkout _payment overide',
  remove: '[data-hook="coupon_code"]',
  text: %q{
  }
)

