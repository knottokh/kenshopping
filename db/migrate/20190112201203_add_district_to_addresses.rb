class AddDistrictToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_addresses, :district_id, :integer
    add_column :spree_addresses, :district_name, :string
    add_index :spree_addresses, :district_id
    add_column :spree_addresses, :subdistrict_id, :integer
    add_column :spree_addresses, :subdistrict_name, :string
    add_index :spree_addresses, :subdistrict_id
  end
end
