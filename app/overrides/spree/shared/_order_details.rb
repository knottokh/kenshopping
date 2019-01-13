Deface::Override.new(
  virtual_path: 'spree/shared/_order_details',
  name: 'shared _order_details overide',
  replace: '[data-hook="order-shipment"]',
  text: %q{
  <div class="col-md-3 col-sm-3" data-hook="order-shipment">
        <h4><%= Spree.t(:shipments) %> <%= link_to "(#{Spree.t(:edit)})", checkout_state_path(:delivery) unless order.completed? %></h4>
        <div class="delivery">
          <% order.shipments.each do |shipment| %>
            <div>
              <i class='fa fa-truck'></i>
              <%= Spree.t(:shipment_details, stock_location: shipment.stock_location.name, shipping_method: shipment.selected_shipping_rate.name) %>
            </div>
            <% unless shipment.tracking.nil? %>
                <h6><%= Spree.t(:tracking) %></h6>
                <p><%= shipment.tracking %></p>
            <% end %>
            
          <% end %>
        </div>
      </div>
  }
)

Deface::Override.new(
  virtual_path: 'spree/shared/_order_details',
  name: 'shared _order_details line_item_row overide',
  replace: '#line-items',
  text: %q{
    <table id='line-items' class="table" data-hook="order_details">
          <col width="15%" valign="middle" halign="center">
          <col width="70%" valign="middle">
          <col width="5%" valign="middle" halign="center">
          <col width="5%" valign="middle" halign="center">
          <col width="5%" valign="middle" halign="center">
        
          <thead data-hook>
            <tr class="active" data-hook="order_details_line_items_headers">
              <th colspan="2"><%= Spree.t(:item) %></th>
              <th ><%= Spree.t(:tracking) %></th>
              <th class="price"><%= Spree.t(:price) %></th>
              <th class="qty"><%= Spree.t(:qty) %></th>
              <th class="total"><span><%= Spree.t(:total) %></span></th>
            </tr>
          </thead>
        
          <tbody data-hook>
            <% order.shipments.each do |shipment| %>
                <% shipment.manifest.each do |item| %>
                    <tr data-hook="order_details_line_item_row">
                    <td data-hook="order_item_image">
                      <% if item.variant.images.length == 0 %>
                        <%= link_to small_image(item.variant.product), item.variant.product %>
                      <% else %>
                        <%= link_to image_tag(main_app.url_for(item.variant.images.first.url(:small))), item.variant.product %>
                      <% end %>
                    </td>
                    <td data-hook="order_item_description">
                      <h4><%= item.variant.product.name %></h4>
                      <%= truncate(item.variant.product.description, length: 100) %>
                      <%= "(" + item.variant.options_text + ")" unless item.variant.option_values.empty? %>
                    </td>
                    <td style="white-space: nowrap;" class="lead text-success total"><span><%= shipment.tracking %></span></td>
                    <td data-hook="order_item_price" class="lead text-primary price"><span><%= item.line_item.single_money.to_html %></span></td>
                    <td data-hook="order_item_qty" class="order-qty"><%= item.quantity %></td>
                    <td data-hook="order_item_total" class="lead text-primary total"><span><%= item.line_item.display_amount.to_html %></span></td>
                  </tr>
                <% end %>
            <% end %>
          </tbody>
          <tfoot id="order-total" data-hook="order_details_total">
            <tr class="warning total">
              <td colspan="5" align="right"><b><%= Spree.t(:order_total) %>:</b></td>
              <td class="total"><span id="order_total" class="lead text-primary"><%= order.display_total.to_html %></span></td>
            </tr>
          </tfoot>
        
          <tfoot id="subtotal" data-hook="order_details_subtotal">
            <tr class="total" id="subtotal-row">
              <td colspan="5"><b><%= Spree.t(:subtotal) %>:</b></td>
              <td class="total"><span><%= order.display_item_total.to_html %></span></td>
            </tr>
          </tfoot>
        
          <% if order.line_item_adjustments.exists? %>
            <% if order.line_item_adjustments.promotion.eligible.exists? %>
              <tfoot id="price-adjustments" data-hook="order_details_price_adjustments">
                <% order.line_item_adjustments.promotion.eligible.group_by(&:label).each do |label, adjustments| %>
                 <tr class="total">
                   <td colspan="5"><%= Spree.t(:promotion) %>: <strong><%= label %></strong></td>
                   <td class="total"><span><%= Spree::Money.new(adjustments.sum(&:amount), currency: order.currency) %></span></td>
                 </tr>
               <% end %>
             </tfoot>
            <% end %>
          <% end %>
        
          <tfoot id='shipment-total'>
            <% order.shipments.group_by { |s| s.selected_shipping_rate.name }.each do |name, shipments| %>
              <tr class="total" data-hook='shipment-row'>
                <td colspan="5" align="right" class="text-muted"><%= Spree.t(:shipping) %>: <strong><%= name %></strong></td>
                <td class="total"><span><%= Spree::Money.new(shipments.sum(&:discounted_cost), currency: order.currency).to_html %></span></td>
              </tr>
            <% end %>
          </tfoot>
        
          <% if order.all_adjustments.tax.exists? %>
            <tfoot id="tax-adjustments" data-hook="order_details_tax_adjustments">
              <% order.all_adjustments.tax.group_by(&:label).each do |label, adjustments| %>
                <tr class="total">
                  <td colspan="5" align="right" class="text-muted"><%= Spree.t(:tax) %>: <strong><%= label %></strong></td>
                  <td class="total"><span><%= Spree::Money.new(adjustments.sum(&:amount), currency: order.currency) %></span></td>
                </tr>
              <% end %>
            </tfoot>
          <% end %>
        
          <tfoot id="order-charges" data-hook="order_details_adjustments">
            <% order.adjustments.eligible.each do |adjustment| %>
              <% next if (adjustment.source_type == 'Spree::TaxRate') and (adjustment.amount == 0) %>
              <tr class="total">
                <td colspan="5" align="right"><strong><%= adjustment.label %></strong></td>
                <td class="total"><span><%= adjustment.display_amount.to_html %></span></td>
              </tr>
            <% end %>
          </tfoot>
        </table>

  }
)