Deface::Override.new(
  virtual_path: 'spree/checkout/payment/_banktransfer',
  name: '_banktransfer overide',
  replace: "#howtobankwork",
  text: %q{
    Transfer to 54854878 bangkok bank
  }
)