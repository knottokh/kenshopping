class CreateSpreeSubdistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_subdistricts do |t|
      t.string "name"
      t.string :code
      t.timestamps
    end
    #add_column :spree_postcodes, :country_id, :integer
    #add_index :spree_postcodes, :country_id
    #add_column :spree_postcodes, :state_id, :integer
    #add_index :spree_postcodes, :state_id
    add_column :spree_postcodes, :district_id, :integer
    add_index :spree_postcodes, :district_id
  end
end
