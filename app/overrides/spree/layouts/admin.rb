Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'admin overide',
  insert_bottom: "[data-hook='admin_inside_head']",
  text: %q{
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  }
)