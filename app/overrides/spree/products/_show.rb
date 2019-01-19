Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'spree products show overide',
  insert_after: '#product-description h1.product-title',
  text: %q{
      <% if @product.recommend %>
         <p class="icon-reccommend">icon reccommend</p>
     <% end %>
     <% show_seller_check = Spree::Product.best_sellers %>
    <% unless show_seller_check.present? %>
         <% unless show_seller_check.select { |pt| pt.id == @product.id }.empty? %>
            <p class="icon-base-sellers">icon base sellers</p>
         <% end %>    
    <% end %>
  }
)