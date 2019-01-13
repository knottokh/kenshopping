Deface::Override.new(
  virtual_path: 'spree/orders/edit',
  name: 'orders edit overide',
  replace: "[data-hook='cart_buttons']",
  text: %q{
            <div class="links col-md-offset-6 col-md-6" data-hook="cart_buttons">
              <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-6">
                  <%= button_tag class: 'btn btn-block btn-primary', id: 'update-button' do %>
                    <%= Spree.t(:cart_update) %>
                  <% end %>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-6">
                  <%= button_tag class: 'btn btn-block btn-success', id: 'checkout-link', name: 'checkout' do %>
                    <%= Spree.t(:checkout) %>
                  <% end %>
                </div>
              </div>
            </div>
  }
)
Deface::Override.new(
  virtual_path: 'spree/orders/edit',
  name: 'orders edit coupon_code overide',
  replace: "[data-hook='coupon_code']",
  text: %q{

  }
)