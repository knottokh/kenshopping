Deface::Override.new(
  virtual_path: 'spree/admin/countries/_form',
  name: 'spree admin countries _form overide',
  insert_after: "[data-hook='states_required']",
  text: %q{
    <div data-hook="isactive_required" class="checkbox">
      <label>
        <%= f.check_box :isactive %>
        <%= Spree.t(:isactive) %>
      </label>
    </div>
  }
)
Deface::Override.new(
  virtual_path: 'spree/admin/countries/index',
  name: 'spree admin countries index overide',
  replace: "#listing_countries",
  text: %q{
    <table class="table" id='listing_countries' data-hook>
  <thead>
    <tr data-hook="tax_header">
      <th><%= Spree.t(:country_name) %></th>
      <th><%= Spree.t(:iso_name) %></th>
      <th><%= Spree.t(:states_required) %></th>
      <th><%= Spree.t(:isactive) %></th>
      <th class="actions"></th>
    </tr>
  </thead>
  <tbody>
    <% @countries.each do |country| %>
        <tr id="<%= spree_dom_id country %>" data-hook="country_row">
          <td><%= country.name %></td>
          <td><%= country.iso_name %></td>
          <td class="text-center"><%= country.states_required? ? Spree.t(:say_yes) : Spree.t(:say_no) %></td>
          <td class="text-center"><%= country.isactive ? Spree.t(:isactive_yes) : Spree.t(:isactive_no) %></td>
          <td class="actions actions-2 text-right">
            <%= link_to_edit(country, no_text: true) if can? :edit, country %>
            <%= link_to_delete(country, no_text: true) if can? :delete, country %>
          </td>
        </tr>
      <% end %>
    </tbody>
  </table>
  }
)