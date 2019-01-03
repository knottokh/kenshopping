Deface::Override.new(
  virtual_path: 'spree/shared/_header2',
  name: '_header overide',
  replace: "header.primary-header",
  text: %q{
      <nav class="navbar navbar-default">
        <div class="container-fluid">
              <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <div id="logo" class="logo_area navbar-brand" data-hook>
                  <%= link_to (image_tag 'logo.svg'), root_path %>
                </div>
              </div>
              <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                  <li><%= link_to Spree.t(:findmyorder), spree.search_order_index_path , data: { modal: true } %></li>
                  <li id="link-to-cart" data-hook>
                     <noscript>
                        <%= link_to Spree.t(:cart), "/cart" %>
                     </noscript>
                  </li>
                  <% if spree_current_user %>
                    <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                      <ul class="dropdown-menu">
                        <li><%= link_to Spree.t(:my_account), spree.account_path %></li>
                        <li><%= link_to Spree.t(:logout), spree.logout_path %></li>
                      </ul>
                    </li>
                  <% else %>
                      <li id="link-to-login"><%= link_to Spree.t(:login), spree.login_path , data: { modal: true } %></li>
                  <% end %>
                  
                </ul>
                <div class="navbar-form navbar-right search_area">
                  <a href="javascript:void(0);" class="close_this search_toggle"></a>
                  <% @taxons = @taxon && @taxon.parent ? @taxon.parent.children : Spree::Taxon.roots %>
                  <%= form_tag spree.products_path, method: :get do %>
                    <!-- <div class="form-group"> -->
                      <%# cache(cache_key_for_taxons) do %>
                        <%#= select_tag :taxon,
                              options_for_select([[Spree.t(:all_departments), '']] +
                                                    @taxons.map {|t| [t.name, t.id]},
                                                    @taxon ? @taxon.id : params[:taxon]), 'aria-label' => 'Taxon', class: "form-control" %>
                      <%# end %>
                    <!-- </div> -->
                    <%= search_field_tag :keywords, params[:keywords], placeholder: Spree.t(:search), class: "" %>
                    <%= button_tag '', name: nil, class: "fa fa-search search-btn" %>
                  <% end %>
                </div>
              </div>
        </div>
    </nav>
    <div class="main_menu">
      <a href="javascript:void(0);" class="close_this main_menu_toggle"></a>
    
      <% if @taxonomies.present? %>
        <div class="main_navigation">
          <% max_level = Spree::Config[:max_level_in_taxons_menu] || 1 %>
          <% @taxonomies.each do |taxonomy| %>
            <% cache [I18n.locale, taxonomy, max_level, @taxon] do %>
              <% if taxonomy.root.children.any? %>
                <%= taxons_tree(taxonomy.root, @taxon, max_level) %>
              <% end %>
            <% end %>
          <% end %>
        </div>
      <% end %>
    
    </div>
  }
)