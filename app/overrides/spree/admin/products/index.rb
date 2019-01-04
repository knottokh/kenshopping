Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'spree admin products index overide',
  replace: "#listing_products",
  text: %q{
        <table class="table" id="listing_products">
        <thead>
          <tr data-hook="admin_products_index_headers">
            <th><%= Spree.t(:sku) %></th>
            <th><%= Spree.t(:status) %></th>
    
            <th colspan="2"><%= sort_link @search,:name, Spree.t(:name), { default_order: "desc" }, {title: 'admin_products_listing_name_title'} %></th>
            <th class="text-center">
              <%= sort_link @search, :master_default_price_amount, Spree.t(:master_price), {}, {title: 'admin_products_listing_price_title'} %>
            </th>
            <th><%= Spree.t(:stock) %></th>
            <th data-hook="admin_products_index_header_actions" class="actions"></th>
          </tr>
        </thead>
        <tbody>
          <% @collection.each do |product| %>
              <tr <%== "style='color: red;'" if product.deleted? %> id="<%= spree_dom_id product %>" data-hook="admin_products_index_rows" class="<%= cycle('odd', 'even') %>">
                <td class="sku"><%= product.sku rescue '' %></td>
                <td class="status"><%= available_status(product) %> </td>
                <td class="image"><%= mini_image product %></td>
                <td><%= link_to product.try(:name), edit_admin_product_path(product) %></td>
                <td class="text-center"><%= product.display_price.to_html rescue '' %></td>
                <td><%= product.total_on_hand %></td>
                <td class="actions actions-3 text-right" data-hook="admin_products_index_row_actions">
                  <%= link_to_edit product, no_text: true, class: 'edit' if can?(:edit, product) && !product.deleted? %>
                  <%= link_to_clone product, no_text: true, class: 'clone' if can?(:clone, product) %>
                  <%= link_to_delete product, no_text: true if can?(:delete, product) && !product.deleted? %>
                </td>
              </tr>
          <% end %>
        </tbody>
      </table>
  }
)
Deface::Override.new(
  virtual_path: 'spree/admin/products/index',
  name: 'spree admin products index filter overide',
  replace: "[data-hook='admin_products_index_search']",
  text: %q{
        <div data-hook="admin_products_index_search" class="row">
        <div class="col-xs-12 col-md-6">
          <div class="form-group">
            <%= f.label :name_cont, Spree.t(:name) %>
            <%= f.text_field :name_cont, size: 15, class: "form-control js-quick-search-target js-filterable" %>
          </div>
        </div>
        <div class="col-xs-12 col-md-6">
          <div class="form-group">
            <%= f.label :variants_including_master_sku_cont, Spree.t(:sku) %>
            <%= f.text_field :variants_including_master_sku_cont, size: 15, class: "form-control js-filterable" %>
          </div>
        </div>
        <div class="col-xs-12 col-md-12">
          <div class="field checkbox">
            <label>
              <%= f.check_box :deleted_at_null, {checked: params[:q][:deleted_at_null] == '0'}, '0', '1' %>
              <%= Spree.t(:show_deleted) %>
            </label>
          </div>

          <div class="field checkbox">
            <label>
              <%= f.check_box :not_discontinued, {checked: params[:q][:not_discontinued] == '0'}, '0', '1' %>
              <%= Spree.t(:show_discontinued ) %>
            </label>
          </div>
          <div class="field checkbox">
            <label>
              <%= f.check_box :out_of_stock, {checked: params[:q][:out_of_stock] == '0'}, '0', '1' %>
              <%= Spree.t(:show_outofstock ) %>
            </label>
          </div>
        </div>
      </div>
  }
)