class AddActivetoCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_countries, :isactive, :boolean, :default => true
  end
end
