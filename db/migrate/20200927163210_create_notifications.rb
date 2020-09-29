class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.float :sigma, null: false, default: 1
      t.integer :mv_period, null: false, default: 10
      t.boolean :activated, null: false, default: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
