Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'spree products show overide',
  insert_after: '#product-description h1.product-title',
  text: %q{
      <% if @product.recommend %>
         <p class="icon-reccommend">icon reccommend</p>
     <% end %>
     <% chk_sellerid = Spree::Product.best_sellers.select { |pt| pt.id == @product.id } %>
        <% unless chk_sellerid.empty? %>
        <p class="icon-base-sellers">icon base sellers</p>
    <% end %>
  }
)