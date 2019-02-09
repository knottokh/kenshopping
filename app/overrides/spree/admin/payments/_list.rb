Deface::Override.new(
  virtual_path: 'spree/admin/payments/_list',
  name: 'spree admin payments _list overide',
  replace: "[data-hook='payments_row']",
  text: %q{
    <tr id="<%= dom_id(payment) %>" data-hook="payments_row" data-number="<%= payment.number %>">
        <td><%= payment.number %></td>
        <td><%= pretty_time(payment.created_at) %></td>
        <td class="amount text-center"><%= payment.display_amount %></td>
        <td class="text-center"><%= payment_method_name(payment) %></td>
        <td class="text-center"><%= payment.transaction_id %></td>
        <td class="text-center">
          <span class="label label-<%= payment.state %>">
            <%= Spree.t(payment.state, scope: :payment_states, default: payment.state.capitalize) %>
          </span>
        </td>
        <td class="custom-actions custom-actions-2 text-center">
          <% payment.actions.each do |action| %>
            <% if action == 'credit' %>
              <%= link_to_with_icon('refund', Spree.t(:refund), new_admin_order_payment_refund_path(@order, payment), no_text: true, class: "btn btn-default btn-sm") if can?(:create, Spree::Refund) %>
            <% else%>
              <%= link_to_with_icon(action, Spree.t(action), fire_admin_order_payment_path(@order, payment, e: action), method: :put, no_text: true, data: { action: action ,confirm: Spree.t(:confirm_payment, text: action)}, class: "btn btn-default btn-sm") if can?(action.to_sym, payment) %>
            <% end %>
          <% end %>
        </td>
      </tr>
  }
)