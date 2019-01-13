module Spree
  module Admin
    class SubdistrictsController < ResourceController
      belongs_to 'spree/district'
      before_action :load_data

      def index
        respond_with(@collection) do |format|
          format.html
          format.js { render partial: 'subdistrict_list' }
        end
      end

      protected

      def location_after_save
        admin_district_subdistricts_url(@district)
      end

      def collection
        super.order(:name)
      end

      def load_data
        @districts = Spree::District.order(:name)
      end
    end
  end
end