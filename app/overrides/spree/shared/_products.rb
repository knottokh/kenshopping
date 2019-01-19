Deface::Override.new(
  virtual_path: 'spree/shared/_products',
  name: 'spree shared _products  overide',
  replace: '#products',
  text: %q{
        <% config = Spree::BestSellersConfiguration.new %>
        <% if (config.has_preference?(:show_best_sellers) && config[:show_best_sellers]) && @best_sellers.present? %>
            <div class="col-lg-12 col-sm-12">
                <h3 class="title"><%= Spree.t('best_sellers.title')%></h3>
            </div>
            <div id="best-sellers" class="product-list" data-hook>
              <% @best_sellers.each do |product| %>
                <div class="col-md-3">
                  <% url = spree.product_path(product, taxon_id: @taxon.try(:id)) %>
                  <div id="product_<%= product.id %>" data-hook="products_list_item" class="product-list-item" itemscope itemtype="https://schema.org/Product">
                    <% cache(@taxon.present? ? [I18n.locale, current_currency, @taxon, product] : cache_key_for_product(product)) do %>
                        <%= link_to url, itemprop: "url" do %>
                          <div class="product_image_area">
                            <%= product_image(product, itemprop: "image", class: "img-responsive center-block") %>
                          </div>
                          <%= content_tag(:div, truncate(product.name, length: 50), class: 'info product_name', itemprop: "name", title: product.name) %>
                        <% end %>
                        <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                          <div class="price selling" itemprop="price"><%= display_price(product) %></div>
                        </div>
                    <% end %>
                  </div>
                 </div>  
              <% end %>
              <% reset_cycle("classes") %>
              
            </div>
            <hr/>
        <% end %>  
       <div id="products" class="product-list" data-hook>
        <% products.each do |product| %>
          <div class="col-md-3">
            <% url = spree.product_path(product, taxon_id: @taxon.try(:id)) %>
            <div id="product_<%= product.id %>" data-hook="products_list_item" class="product-list-item" itemscope itemtype="https://schema.org/Product">
              <% cache(@taxon.present? ? [I18n.locale, current_currency, @taxon, product] : cache_key_for_product(product)) do %>
                  <%= link_to url, itemprop: "url" do %>
                    <div class="product_image_area">
                      <% if product.recommend %>
                          <p class="icon-reccommend">icon reccommend</p>
                      <% end %>
                      <% if @best_sellers.present? %>
                          <% chk_sellerid = @best_sellers %>
                          <% unless chk_sellerid.empty? %>
                            <% unless chk_sellerid.select { |pt| pt.id == product.id }.empty? %>
                              <p class="icon-base-sellers">icon base sellers</p>
                            <% end %> 
                          <% end %>  
                      <% end %>
                      <%= product_image(product, itemprop: "image", class: "img-responsive center-block") %>
                    </div>
                    <%= content_tag(:div, truncate(product.name, length: 50), class: 'info product_name', itemprop: "name", title: product.name) %>
                  <% end %>
                  <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                    <div class="price selling" itemprop="price"><%= display_price(product) %></div>
                  </div>
              <% end %>
            </div>
           </div>  
        <% end %>
        <% reset_cycle("classes") %>
      </div>
  }
)