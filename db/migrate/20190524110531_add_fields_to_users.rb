# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string, default: :user
    add_column :users, :contact_number, :string
    add_column :users, :profile_picture, :string
  end
end
