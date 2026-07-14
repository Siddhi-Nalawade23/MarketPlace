class CreateInvoices < ActiveRecord::Migration[8.1]
    def change
    create_table :invoices do |t|
      t.references :order, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.string :invoice_number
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
