Deface::Override.new(
  virtual_path: 'spree/shared/_products',
   name: 'hide best_sellers',
  replace: "#best-sellers",
  text: %q{}
)