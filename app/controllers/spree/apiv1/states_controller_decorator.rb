Spree::Api::V1::StatesController.class_eval do
    private
    def scope
        orderby = "name asc"
        if ENV['RAILS_ENV'] == "production"
          orderby = 'name collate "C" asc'
        end 
          if params[:country_id]
            @country = Spree::Country.accessible_by(current_ability, :read).find(params[:country_id])
            @country.states.accessible_by(current_ability, :read).order(orderby)
          else
            Spree::State.accessible_by(current_ability, :read).order(orderby)
          end
    end
end