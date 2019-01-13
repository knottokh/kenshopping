Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'spree admin products _form overide',
  insert_after: '[data-hook="admin_product_form_cost_currency"]',
  text: %q{
      <div data-hook="admin_product_form_recommend">
        <%= f.field_container :recommend, class: ['form-group'] do %>
          <%= f.label :recommend, Spree.t(:recommend) %>
          <%= f.error_message_on :recommend %>
          <%= f.check_box :recommend, class: 'form-control' %>
        <% end %>
     </div>
  }
)