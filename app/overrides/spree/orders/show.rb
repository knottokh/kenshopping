Deface::Override.new(
  virtual_path: 'spree/orders/show',
  name: 'orders show overide',
  insert_before: "#order",
  text: %q{
      <table class="table table-striped order-summary">
          <thead class="active">
          <tr>
            <th class="order-date"><%= Spree.t(:date) %></th>
            <th class="order-status"><%= Spree.t(:status) %></th>
            <th class="order-payment-state"><%= Spree.t(:payment_state) %></th>
            <th class="order-shipment-state"><%= Spree.t(:shipment_state) %></th>
          </tr>
          </thead>
          <tbody>
            <tr>
              <td class="order-date"><%= l @order.completed_at.to_date %></td>
              <td class="order-status"><%= Spree.t("order_states.#{@order.state}").titleize %></td>
              <td class="order-payment-state"><%= Spree.t("payment_states.#{@order.payment_state}").titleize if @order.payment_state %></td>
              <td class="order-shipment-state"><%= Spree.t("shipment_states.#{@order.shipment_state}").titleize if @order.shipment_state %></td>
            </tr>
          </tbody>
        </table>
  }
)