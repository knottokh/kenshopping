class CreateSpreeDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_districts do |t|
      t.string :name
      t.string :code
      t.string :postcode
      t.timestamps
    end
    #add_column :spree_districts, :country_id, :integer
    #add_index :spree_districts, :country_id
    add_column :spree_districts, :state_id, :integer
    add_index :spree_districts, :state_id
  end
end
