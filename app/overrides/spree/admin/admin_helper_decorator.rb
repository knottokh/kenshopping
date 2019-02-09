Spree::Admin::NavigationHelper.class_eval do
    def link_to_delete_order(order, options = {})
        options[:data] = { action: 'delete', original: {title: Spree.t(:delete)}, 
                            confirm:  Spree.t('order_confirm_delete', number: order.number)}
        options[:class] = 'btn btn-danger btn-sm with-tip'
        options[:method] = :delete
        options[:icon] = :delete
        button_link_to '', admin_order_path(order), options
    end    
    def link_to_delete_url(url, options = {})
        options[:data] = { action: 'delete' }
        options[:class] = 'btn btn-primary btn-sm'
        link_to_with_icon('delete', Spree.t(:delete), url, options)
    end
end