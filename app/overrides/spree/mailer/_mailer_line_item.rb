Deface::Override.new(
  virtual_path: 'spree/shared/_mailer_line_item',
  name: 'shared _mailer_line_item overide',
  replace: "tr",
  text: %q{
    <tr>
      <td class="six sub-columns">
        <strong>
          <% if frontend_available? %>
            <%= link_to raw(line_item.variant.product.name), spree.product_url(line_item.variant.product) %>
          <% else %>
            <%= raw(line_item.variant.product.name) %>
          <% end %>
        </strong>
        <%= raw(line_item.variant.options_text) -%>
        <% unless  line_item.variant.sku.nil? %>
            (<%= line_item.variant.sku %>)
        <% end %>
        
      </td>
      <td class="six sub-columns last right">
        <%= line_item.quantity %> x <%= line_item.single_money %> = <%= line_item.display_amount %>
      </td>
    </tr>
  }
)