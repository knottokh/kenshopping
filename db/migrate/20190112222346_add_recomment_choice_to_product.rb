class AddRecommentChoiceToProduct < ActiveRecord::Migration[5.2]
  def change
      add_column :spree_products, :recommend, :boolean ,:default => false
  end
end
