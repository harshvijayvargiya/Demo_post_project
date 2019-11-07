class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :price, :integer
  end
end
