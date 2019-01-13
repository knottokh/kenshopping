class AddTaxidToAddresses < ActiveRecord::Migration[5.2]
  def change
      add_column :spree_addresses, :taxid, :string
  end
end
