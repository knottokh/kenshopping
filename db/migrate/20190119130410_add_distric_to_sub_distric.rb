class AddDistricToSubDistric < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_subdistricts, :district_id, :integer
    add_index :spree_subdistricts, :district_id
  end
end
