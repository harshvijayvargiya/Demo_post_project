class CreateMultipleposts < ActiveRecord::Migration[5.2]
  def change
    create_table :multipleposts do |t|
      t.string :attchment
      t.string :article

      t.timestamps
    end
  end
end
