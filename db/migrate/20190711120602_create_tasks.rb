class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :attchment
      t.string :article
      t.belongs_to :multiplepost, foreign_key: true

      t.timestamps
    end
  end
end
