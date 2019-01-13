Deface::Override.new(
  virtual_path: 'spree/checkout/_address',
  name: 'checkout _address overide',
  replace: "[data-hook='buttons']",
  text: %q{
    <div class="well form-buttons" data-hook="buttons">
      <div class="row">
        <div class="col-md-5 col-sm-6">
          <%= submit_tag Spree.t(:save_and_continue), class: 'btn btn-lg btn-block btn-success' %>
        </div>
        <div class="col-md-offset-4 col-md-3 col-sm-offset-3 col-sm-3">
          <% if try_spree_current_user %>
            <span data-hook="save_user_address" class="radio_check d-ib mt15">
              <%= check_box_tag 'save_user_address', '1', try_spree_current_user.respond_to?(:persist_order_address) %>
              <%= label_tag :save_user_address, Spree.t(:save_my_address) %>
            </span>
          <% end %>
        </div>
      </div>
    </div>
  }
)