Deface::Override.new(
  virtual_path: 'spree/admin/orders/index',
  name: 'spree admin orders index overide',
  replace: "tr[data-hook='admin_orders_index_rows']",
  text: %q{
     <tr data-hook="admin_orders_index_rows" class="state-<%= order.state.downcase %> <%= cycle('odd', 'even') %>">
        <td>
          <%= order_time(@show_only_completed ? order.completed_at : order.created_at) %>
        </td>
        <td><%= link_to order.number, summary_admin_order_path(order) %></td>
        <td>
          <span class="label label-<%= order.considered_risky ? 'considered_risky' : 'considered_safe' %>">
            <%= order.considered_risky ? Spree.t("risky") : Spree.t("safe") %>
          </span>
        </td>
        <td>
          <span class="label label-<%= order.state.downcase %>"><%= Spree.t("order_state.#{order.state.downcase}") %></span>
          <span class="icon icon-filter filterable js-add-filter" data-ransack-field="q_state_eq" data-ransack-value="<%= order.state %>"></span>
        </td>
        <td>
          <% if order.payment_state %>
            <span class="label label-<%= order.payment_state %>"><%= link_to Spree.t("payment_states.#{order.payment_state}"), admin_order_payments_path(order) %></span>
            <span class="icon icon-filter filterable js-add-filter" data-ransack-field="q_payment_state_eq" data-ransack-value="<%= order.payment_state %>"></span>
          <% end %>
        </td>
        <% if Spree::Order.checkout_step_names.include?(:delivery) %>
          <td>
            <% if order.shipment_state %>
              <span class="label label-<%= order.shipment_state %>"><%= Spree.t("shipment_states.#{order.shipment_state}") %></span>
              <span class="icon icon-filter filterable js-add-filter" data-ransack-field="q_shipment_state_eq" data-ransack-value="<%= order.shipment_state %>"></span>
            <% end %>
          </td>
        <% end %>
        <td>
          <% if order.user %>
            <%= link_to order.email, edit_admin_user_path(order.user) %>
          <% else %>
            <%= mail_to order.email %>
          <% end %>
          <% if order.user || order.email %>
            <span class="icon icon-filter filterable js-add-filter" data-ransack-field="q_email_cont" data-ransack-value="<%= order.email %>"></span>
          <% end %>
        </td>
        <td><%= order.display_total.to_html %></td>
        <td class='actions actions-1' data-hook="admin_orders_index_row_actions">
          <%= link_to_edit_url summary_admin_order_path(order), title: "admin_edit_#{dom_id(order)}", no_text: true if can?(:edit, order) %>
          <%= link_to_delete_order order, no_text: true, class: 'delete' if can?(:delete, order) %>
        </td>
      </tr>
  }
)