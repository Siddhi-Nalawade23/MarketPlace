class DropSellers < ActiveRecord::Migration[8.1]
  def up
    drop_table :sellers if table_exists?(:sellers)
  end

  def down
    create_table :sellers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shop_name
      t.boolean :approved, default: false, null: false

      t.timestamps
    end
  end
end
