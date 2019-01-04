Spree::Admin::ProductsController.class_eval do
    def collection
        return @collection if @collection.present?

        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= '1'
        params[:q][:not_discontinued] ||= '1'
        params[:q][:out_of_stock] ||= '1'

        params[:q][:s] ||= 'name asc'
        @collection = super
        # Don't delete params[:q][:deleted_at_null] here because it is used in view to check the
        # checkbox for 'q[deleted_at_null]'. This also messed with pagination when deleted_at_null is checked.
        if params[:q][:deleted_at_null] == '0'
          @collection = @collection.with_deleted
        end
        if params[:q][:out_of_stock] == '0'
            @collection = @collection.joins(variants_including_master: :stock_items).
                         group(:product_id).having("sum(count_on_hand) <= 0")
        end              
        # @search needs to be defined as this is passed to search_form_for
        # Temporarily remove params[:q][:deleted_at_null] from params[:q] to ransack products.
        # This is to include all products and not just deleted products.
        @search = @collection.ransack(params[:q].reject { |k, _v| k.to_s == 'deleted_at_null' or k.to_s == 'out_of_stock'})
        @collection = @search.result.
                      includes(product_includes).
                      page(params[:page]).
                      per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end
end