class AddLastVisitedAtToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :last_visited_at, :datetime
  end
end
