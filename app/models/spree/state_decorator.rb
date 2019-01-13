Spree::State.class_eval do
   has_many :districts, dependent: :destroy
   
   def self.default
      state_id = Spree::Config[:default_state_id]
      default = find_by(id: state_id) if state_id.present?
      default || find(1) || first
    end

    def default?
      id == Spree::Config[:default_state_id]
    end
end