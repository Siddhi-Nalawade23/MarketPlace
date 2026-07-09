class RemoveSellerFromProducts < ActiveRecord::Migration[8.1]
  def change
    remove_reference :products, :seller, null: false, foreign_key: true
  end
end
