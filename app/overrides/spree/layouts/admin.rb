Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'admin overide',
  insert_bottom: "[data-hook='admin_inside_head']",
  text: %q{
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  }
)