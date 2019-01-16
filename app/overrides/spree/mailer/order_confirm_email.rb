Deface::Override.new(
  virtual_path: 'spree/order_mailer/confirm_email',
  name: 'order_mailer confirm_email overide',
  replace: "table.header",
  text: %q{
    <table class="row header">
          <tr>
            <td>
              <p class="lede">
                <%= Spree.t('order_mailer.confirm_email.dear_customer') %>
              </p>
              <p> 
                <%= Spree.t('order_mailer.confirm_email.thankhead') %> <span style="font-width:bold;color:#4a86e8;"><%= @order.number%></span>
              </p>
              <p>
                <%= Spree.t('order_mailer.confirm_email.linkcheck') %>
              </p>
              <p>
                 <%= link_to "Link", spree.order_url(@order) %>
              </p>  
              <br/>
              <p>
                <%= Spree.t('order_mailer.confirm_email.order_summary', number: @order.number) %>
              </p>
              <table class="container">
                <tr>
                  <td class="wrapper last">
                    <table class="twelve columns">
                      <%= render collection: @order.line_items, partial: 'spree/shared/mailer_line_item', as: :line_item %>
                      <%= render 'spree/order_mailer/subtotal', order: @order %>
                      <% if @order.line_item_adjustments.exists? %>
                        <% if @order.all_adjustments.promotion.eligible.exists? %>
                          <% @order.all_adjustments.promotion.eligible.group_by(&:label).each do |label, adjustments| %>
                            <tr>
                              <td class="six sub-columns">
                                <%= Spree.t(:promotion) %> <%= label %>:
                              </td>
                              <td class="six sub-columns last right">
                                <%= Spree::Money.new(adjustments.sum(&:amount), currency: @order.currency) %>
                              </td>
                            </tr>
                          <% end %>
                        <% end %>
                      <% end %>
                      <% @order.shipments.group_by { |s| s.selected_shipping_rate.try(:name) }.each do |name, shipments| %>
                        <tr>
                          <td class="six sub-columns">
                            <%= Spree.t(:shipping) %> <%= name %>:
                          </td>
                          <td class="six sub-columns last right">
                            <%= Spree::Money.new(shipments.sum(&:discounted_cost), currency: @order.currency) %>
                          </td>
                        </tr>
                      <% end %>
                      <% if @order.all_adjustments.eligible.tax.exists? %>
                        <% @order.all_adjustments.eligible.tax.group_by(&:label).each do |label, adjustments| %>
                          <tr>
                            <td class="six sub-columns">
                              <%= Spree.t(:tax) %> <%= label %>:
                            </td>
                            <td class="six sub-columns last right">
                              <%= Spree::Money.new(adjustments.sum(&:amount), currency: @order.currency) %>
                            </td>
                          </tr>
                        <% end %>
                      <% end %>
                      <% @order.adjustments.eligible.each do |adjustment| %>
                        <% next if (adjustment.source_type == 'Spree::TaxRate') || (adjustment.amount == 0) %>
                        <%= render 'spree/order_mailer/adjustment', adjustment: adjustment %>
                      <% end %>
                      <%= render 'spree/order_mailer/total', order: @order %>
                    </table>
                  </td>
                </tr>
              </table>
              <br/>
              <p>
                <%= Spree.t('order_mailer.confirm_email.contactinfo') %>
              </p>
              <br/>
              <p>
                <%= Spree.t('order_mailer.confirm_email.thanks') %>
              </p>
            </td>
            <td class="expander"></td>
          </tr>
        </table>
  }
)