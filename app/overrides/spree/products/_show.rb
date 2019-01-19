Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'spree products show overide',
  insert_after: '#product-description h1.product-title',
  text: %q{
      <% if @product.recommend %>
         <p class="icon-reccommend">icon reccommend</p>
     <% end %>
     <% chk_sellerid = Spree::Product.best_sellers %>
    <% unless chk_sellerid.empty? %>
         <% unless chk_sellerid.select { |pt| pt.id == @product.id }.empty? %>
            <p class="icon-base-sellers">icon base sellers</p>
         <% end %>    
    <% end %>
  }
)