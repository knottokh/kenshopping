Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'spree_application overide',
  insert_bottom: "[data-hook='inside_head']",
  text: %q{
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
    <%= javascript_include_tag 'applicationfront', 'data-turbolinks-track' => true %>

  }
)