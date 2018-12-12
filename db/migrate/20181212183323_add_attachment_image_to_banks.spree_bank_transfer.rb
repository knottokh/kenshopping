# This migration comes from spree_bank_transfer (originally 20181213003958)
class AddAttachmentImageToBanks < ActiveRecord::Migration[4.2]
  def self.up
    change_table :spree_banks do |t|
      t.attachment :bank_attachment
    end
    change_table :spree_payments do |t|
      t.attachment :bank_attachment
    end
  end

  def self.down
    remove_attachment :spree_banks, :bank_attachment
    remove_attachment :spree_payments, :bank_attachment
  end
end