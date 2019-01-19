class AddDistricToSubDistric < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_districts, :district_id, :integer
    add_index :spree_districts, :district_id
  end
end
