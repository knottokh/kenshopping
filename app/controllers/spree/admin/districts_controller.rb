module Spree
  module Admin
    class DistrictsController < ResourceController
      belongs_to 'spree/state'
      before_action :load_data

      def index
        respond_with(@collection) do |format|
          format.html
          format.js { render partial: 'district_div_list' }
        end
      end
      
      protected

      def location_after_save
        admin_state_districts_url(@state)
      end

      def collection
        orderby = "name"
        if ENV['RAILS_ENV'] == "production"
          orderby = 'name collate "C"'
        end  
        super.order(orderby)
      end

      def load_data
        orderby = "name"
        if ENV['RAILS_ENV'] == "production"
          orderby = 'name collate "C"'
        end  
        
        @states = Spree::State.order(orderby)
        #@state = Spree::State.all.first
      end
    end
  end
end
