class AddFieldsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :string
    add_column :posts, :count, :integer, default: 0
  end
end
