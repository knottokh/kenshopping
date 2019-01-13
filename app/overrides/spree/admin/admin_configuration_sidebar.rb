Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_districts_to_admin_configuration_sidebar',
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text: %q{
      <% if state = Spree::State.find_by(id: Spree::Config[:default_state_id]) || Spree::State.first %>
        <%= configurations_sidebar_menu_item(Spree.t(:districts), spree.admin_state_districts_path(state)) if can? :manage, Spree::State %>
      <% end %>
      <% if district = Spree::District.find_by(id: Spree::Config[:default_district_id]) || Spree::District.first %>
        <%= configurations_sidebar_menu_item(Spree.t(:subdistricts), spree.admin_district_subdistricts_path(district)) if can? :manage, Spree::District %>
      <% end %>
    }
)
