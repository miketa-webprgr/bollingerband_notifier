class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.datetime :date, null: false
      t.float :close, null: false
      t.float :high
      t.float :low
      t.integer :volume
      t.references :company, null: false, foreign_key: true

      t.index %i[date company_id], unique: true
      t.timestamps
    end
  end
end
