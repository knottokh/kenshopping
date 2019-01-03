Deface::Override.new(
  virtual_path: 'spree/shared/_nav_bar',
  name: '_nav_bar overide',
  replace: "#top-nav-bar",
  text: %q{
     <nav id="top-nav-bar" class="user_bar">
      <a href="javascript:void(0);" class="close_this userbar_toggle"></a>
      <ul id="nav-bar" class="nav navbar-nav" data-hook>
        <li><%= link_to Spree.t(:findmyorder), spree.search_order_index_path , data: { modal: true } %></li>
        <li id="link-to-cart" data-hook>
          <noscript>
            <%= link_to Spree.t(:cart), '/cart' %>
          </noscript>
        </li>
        <script>Spree.fetch_cart()</script>
            <li id="search-bar" data-hook>
        </li>
        <% if spree_current_user %>
          <li><%= link_to Spree.t(:my_account), spree.account_path %></li>
          <li><%= link_to Spree.t(:logout), spree.logout_path %></li>
        <% else %>
          <li id="link-to-login" class="header-top-link"><%= link_to Spree.t(:login), spree.login_path %></li>
        <% end %>
      </ul>
    </nav>   
  }
)